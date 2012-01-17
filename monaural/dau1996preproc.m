function [outsig, fc] = dau1996preproc(insig, fs, varargin);
%DAU1996PREPROC   Auditory model from Dau et. al. 1996.
%   Usage: [outsig, fc] = dau1996preproc(insig,fs);
%          [outsig, fc] = dau1996preproc(insig,fs,...);
%
%   Input parameters:
%     insig  : input acoustic signal.
%     fs     : sampling rate.
%  
%   `dau1996preproc(insig,fs)` computes the internal representation of the
%   signal *insig* sampled with a frequency of *fs* Hz as described in Dau,
%   Puschel and Kohlrausch (1996a).
%  
%   `[outsig,fc]=dau1996preproc(...)` additionally returns the center frequencies of
%   the filter bank.
%
%   The Dau 1996 model consists of the following stages:
%   
%     1) a gammatone filter bank with 1-erb spaced filtes.
%
%     2) an envelope extraction stage done by half-wave rectification
%        followed by low-pass filtering to 1000 Hz.
%
%     3) an adaptation stage modelling nerve adaptation by a cascade of 5
%        loops.
%
%     4) a modulation low pass filter liming modulations to below 50 Hz.
%
%   Any of the optinal parameters for |auditoryfilterbank|_, |ihcenvelope|_
%   and |adaptloop|_ may be specified for this function. They will be passed
%   to the corresponding functions.
%
%   The model implemented in this file is not identical to the model
%   published in Dau et. al. (1996a). An overshoot limit has been added to
%   the adaptation stage to fix a problem where abrupt changes in the
%   input signal would cause unnaturally big responses. This is described
%   in Dau et. al. (1997a).
%
%   See also: auditoryfilterbank, ihcenvelope, adaptloop, dau1997preproc
%
%   References: dau1996qmeI dau1996qmeII dau1997mapI

%   AUTHOR : Torsten Dau, Morten Løve Jepsen, Peter L. Soendergaard
  
% ------ Checking of input parameters ------------

if nargin<2
  error('%s: Too few input arguments.',upper(mfilename));
end;

if ~isnumeric(insig) 
  error('%s: insig must be numeric.',upper(mfilename));
end;

if ~isnumeric(fs) || ~isscalar(fs) || fs<=0
  error('%s: fs must be a positive scalar.',upper(mfilename));
end;

definput.import={'auditoryfilterbank','ihcenvelope','adaptloop'};
definput.importdefaults={'ihc_dau','adt_dau'};
definput.keyvals.subfs=[];

[flags,keyvals]  = ltfatarghelper({'flow','fhigh'},definput,varargin);

% ------ do the computation -------------------------

% Apply the auditory filterbank
[outsig, fc] = auditoryfilterbank(insig,fs,'argimport',flags,keyvals);

% 'haircell' envelope extraction
outsig = ihcenvelope(outsig,fs,'argimport',flags,keyvals);

% non-linear adaptation loops
outsig = adaptloop(outsig,fs,'argimport',flags,keyvals);

% Calculate filter coefficients for the 20 ms (approx.eq to 8 Hz) modulation
% lowpass filter.
% This filter places a pole /very/ close to the unit circle.
mlp_a = exp(-(1/0.02)/fs);
mlp_b = 1 - mlp_a;
mlp_a = [1, -mlp_a];

% Apply the low-pass modulation filter.
outsig = filter(mlp_b,mlp_a,outsig);

% Apply final resampling to avoid excessive data
if ~isempty(keyvals.subfs)
  outsig = fftresample(outsig,round(length(outsig)/fs*subfs));
end;
