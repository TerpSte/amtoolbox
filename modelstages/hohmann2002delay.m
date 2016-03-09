function delay = hohmann2002delay(fb, delay_samples)
%HOHMANN2002DELAY  Create new delay object within HOHMANN2002 filterbank framework
%   Usage: delay = hohmann2002delay(fb, delay_samples)
%
%   Input parameters:
%     fb            : The filterbank structure as returned by |hohmann2002|.
%     delay_samples : The desired group delay in samples. Must be at least 1,
%                     because of the way the phase factors are computed. Larger
%                     delays lead to better signal quality.
%   Output parameters:
%     delay         : The new delay object
%
%   `hohmann2002delay(fb, delay_samples)` creates a new delay object
%   that can act as the first stage of a synthesizer that
%   resynthesizes the output of the gammatone filterbank.  The
%   purpose of the delay object is to delay the output of each band by a
%   band-dependent ammount of samples, so that the envelope of the impulse
%   response of the analyzer is as large as possible at the desired delay.
%   Additionally, the delay object will multiply this delayed output with a
%   band-dependent complex phase factor, so that the real part of the
%   impulse response has a local maximum at the desired delay.  Finally, the
%   delay object will output only the real part of each band.
%  
%   The phase factors are approximated numerically in this constructor,
%   using a method described in Herzke & Hohmann (2007). The
%   approximation assumes parabolic behaviour of the real part of the
%   impulse response in the region of the desired local maximum: The phase
%   factors are chosen so that the real parts of the impulse response in
%   the samples directly preceeding and following the desired local
%   maximum will be equal after multiplication with the pase factor.
%
%   References: herzke2007improved

% author: Universitaet Oldenburg, tp (Jan 2002, Jan, Sep 2003, Nov 2006, Jan 2007)
% Adapted to AMT (PM, Jan 2016) from function gfb_*_process

delay.type           = 'gfb_Delay';

fb = hohmann2002clearstate(fb);
impulse = [1 zeros(1, delay_samples + 2)];
ir = hohmann2002process(fb, impulse);

number_of_bands = size(ir, 1);

[~, max_indices] = max(abs(ir(:,1:(delay_samples+1))).');

delay.delays_samples = delay_samples + 1 - max_indices;

delay.memory = zeros(number_of_bands, max(delay.delays_samples));

slopes = zeros(1, number_of_bands);

for band = 1:number_of_bands
  band_max_index = max_indices(band);
  slopes(band) = (ir(band, band_max_index+1) - ir(band, band_max_index-1));
end
slopes = slopes ./ abs(slopes);
delay.phase_factors = 1i ./ slopes;