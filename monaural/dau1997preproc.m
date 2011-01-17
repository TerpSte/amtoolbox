function [outsig, fc] = dau1997preproc(insig, fs, varargin);
%DAU1997PREPROC   Auditory model from Dau et. al. 1997.
%   Usage: [outsig, fc] = dau1997preproc(insig,fs);
%          [outsig, fc] = dau1997preproc(insig,fs,...);
%
%   Input parameters:
%     insig  : input acoustic signal.
%     fs     : sampling rate.
%  
%   DAU1997PREPROC(insig,fs) computes the internal representation of the signal insig
%   sampled with a frequency of fs Hz as described in Dau, Puschel and
%   Kohlrausch (1996a).
%  
%   [outsig,fc]=DAU1997(...) additionally returns the center frequencies of
%   the filter bank.
%
%   The following parameters may be passed at the end of the line of
%   input arguments:
%
%-     'flow',flow - Set the lowest frequency in the filterbank to
%                    flow. Default value is 80 Hz.
%
%-     'fhigh',fhigh - Set the highest frequency in the filterbank to
%                    fhigh. Default value is 8000 Hz.
%
%-     'basef',basef - Ensure that the frequency basef is a center frequency
%                    in the filterbank. The default value of [] means
%                    no default.
% 
%-     'subfs',subfs - Apply a final downsampling of the subband signals
%                    to subfs Hz to avoid excessive data. The default value
%                    of [] means no downsampling.
%
%   The model assumes than a pure tone input signal with an RMS value of 1
%   corresponds to an acoustic signal of 100 db SPL.
%  
%   The Dau1997 model consists of the following stages:
%   
%     * a gammatone filter bank with 1-erb spaced filtes.
%
%     * an envelope extraction stage done by half-wave rectification
%        followed by low-pass filtering to 1000 Hz.
%
%     * an adaptation stage modelling nerve adaptation by a cascade of 5
%        loops.
%
%     * a modulation filterbank
%
%R  dau1997mapI dau1997mapII

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

definput.keyvals.flow=80;
definput.keyvals.fhigh=8000;
definput.keyvals.basef=[];
definput.keyvals.subfs=[];

[flags,keyvals,flow,fhigh,basef,subfs]  = ltfatarghelper({'flow', ...
                    'fhigh','basef','subfs'},definput,varargin);

% ------ do the computation -------------------------

% find the center frequencies used in the filterbank, 1 ERB spacing
fc = erbspacebw(flow, fhigh, 1, basef);
nfreqchannels = length(fc);

% Calculate filter coefficients for the gammatone filter bank.
[gt_b, gt_a]=gammatone(fc, fs, 'complex');

% Apply the Gammatone filterbank
outsig = 2*real(filterbankz(gt_b,gt_a,insig));

% 'haircell' envelope extraction
outsig = ihcenvelope(outsig,fs,'dau');

% non-linear adaptation loops
outsig = adaptloop(outsig,fs,'dau');

% lowest and highest CFs of the MFB as function of CF
MFlow = fc .* 0;                        % set lowest mf as constant value
MFhigh = min(fc .* 0.25, 1000);         % set highest mf as proportion of CF
[MF_CFs,out] = mfbtd(1,min(MFlow),max(MFhigh),1,fs); % to find the number of MF's

NrMFChannels = size(MF_CFs,2);                  % maximum number of modulation filters

out = zeros(siglen,nfreqchannels,NrMFChannels); % define output array

for ChannelNr = 1:nfreqchannels
    
   % Modulation filterbank
   [infpar,y] = mfbtd(y,MFlow(ChannelNr),MFhigh(ChannelNr),1,fs);	% MFB incl 150 LP
   y = mfbtdpp(y,infpar,fs);
    
   % Fill 'y' into output array 
   out(:,ChannelNr,1:length(infpar)) = y;
            
end





