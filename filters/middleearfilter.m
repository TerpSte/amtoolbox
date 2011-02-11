function b = middleearfilter(fs,order)
%MIDDLEEARFILTER   Middle ear filter.
%   Usage: b=middleearfilter(fs,order);
%          b=middleearfilter(fs);
%          b=middleearfilter;
%
%   MIDDLEEARFILTER(fs,order) computes the filter coefficients of a FIR
%   filter or order _order approximating the effect of the middle ear.
%
%   MIDDLEEARFILTER(fs) does the same with a FIR filter of order 512.
%
%   MIDDLEEARFILTER without any input arguments returns a table
%   describing the frequency response of the middle ear filter. First
%   column of the table contain frequencies and the second column
%   contains the amplitude of the frequency.
%
%   FIXME: Details on the final scaling. Why is it done that way?
%
%   See also: headphonefilter
%
%   Demos: demo_outermiddle
% 
%R  goode1994nkf lopezpoveda2001hnc
  
% Author: Morten L�ve Jepsen, Peter L. Soendergaard


if nargin==1
  order = 512;    % desired FIR filter order
end;

stapes_data = [...
    50,	 48046.39731;...
    100, 24023.19865;...
    200, 12011.59933;...
    400,  6005.799663;...
    600, 3720.406871;...
    800,  2866.404385;...
    1000, 3363.247811;...
    1200, 4379.228921;...
    1400, 4804.639731;...
    1600, 5732.808769;...
    1800, 6228.236688;...
    2000, 7206.959596;...
    2200, 9172.494031;...
    2400, 9554.681282;...
    2600, 10779.64042;...
    2800, 12011.59933;...
    3000, 14013.53255;...
    3500, 16015.46577;...
    4000, 18017.39899;...
    4500, 23852.82136;...
    5000, 21020.29882;...
    5500, 22931.23508;...
    6000, 28027.06509;...
    6500, 28745.70779;...
    7000, 32098.9;...
    7500, 34504.4;...
    8000, 36909.9;...
    8500, 39315.4;...
    9000, 41720.9;...
    9500, 44126.4;...
    10000,46531.9;...
    ];

% We need to find inverse because original data is stapes impedance and we
% need stapes velocity.
stapes_data (:,2) = 1./stapes_data(:,2); 

if nargin==0
  b = stapes_data;
else
  
  if fs<=20000
    % In this case, we need to cut the table because the sampling
    % frequency is too low to accomodate the full range.
    
    indx=find(stapes_data(:,1)<fs/2);
    stapes_data=stapes_data(1:indx(end),:);
  end;  
  
  % Extract the frequencies and amplitudes, and put them in the format
  % that fir2 likes.
  freq=[0;...
        stapes_data(:,1).*(2/fs);...
        1];
  ampl=[0;...
        stapes_data(:,2);...
        0];
  
  b = fir2(order,freq,ampl);
  
  % See the figure text for figure 1, Lopez (2001).
  b = b/max(abs(fft(b)))*1e-8*10^(104/20); 

end;


