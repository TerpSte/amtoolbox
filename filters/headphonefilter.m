function b = headphonefilter(fs,order)
%HEADPHONEFILTER  Combined headphone and outer ear filter.
%   Usage:  b=headphonefilter(fs,order);
%           b=headphonefilter(fs);
%           b=headphonefilter;
%
%   HEADPHONEFILTER(fs,order) computes the filter coefficients of a FIR
%   filter or order _order approximating the combined effect of headphones
%   and the outer ear. The data describes a generic set of headphones.
%
%   HEADPHONEFILTER(fs) does the same with a FIR filter of order 512.
%
%   HEADPHONEFILTER without any input arguments returns a table
%   describing the frequency response of the headphone filter. First
%   column of the table contain frequencies and the second column
%   contains the amplitude of the frequency.
%
%   See also: middleearfilter
%
%   Demos: demo_outermiddle
%   
%R pralong1996rih lopezpoveda2001hnc
  
% Author: Morten L�ve Jepsen, Peter L. Soendergaard


if nargin==1
  order = 512;    % desired FIR filter order
end;

eardrum_data = [...
    125,	1; ...
    250,	1; ...
    500,	1; ...
    1000,	0.994850557; ...
    1237.384651,	0.994850557; ...
    1531.120775,	0.994850557; ...
    1894.585346,	1.114513162; ...
    2002.467159,	1.235743262; ...
    2344.330828,	1.867671314; ...
    2721.273584,	2.822751493; ...
    3001.403462,	2.180544843; ...
    3589.453635,	1.442755787; ...
    4001.342781,	1.173563859; ...
    4441.534834,	1.37016005; ...
    5004.212211,	1.599690164; ...
    5495.887031,	1.37016005; ...
    5997.423738,	1.114513162; ...
    6800.526258,	0.648125625; ...
    6946.931144,	0.631609176; ...
    7995.508928,	0.276505667; ...
    8414.866811,	0.084335217; ...
    9008.422743,	0.084335217; ...
];

if nargin==0
  b = eardrum_data;
else
  
  if fs<=20000
    % In this case, we need to cut the table because the sampling
    % frequency is too low to accomodate the full range.
    
    indx=find(eardrum_data(:,1)<fs/2);
    eardrum_data=eardrum_data(1:indx(end),:);
  end;  

  % Extract the frequencies and amplitudes, and put them in the format
  % that fir2 likes.
  freq=[0;...
        eardrum_data(:,1).*(2/fs);...
        1];
  ampl=[0;...
        eardrum_data(:,2);...
        0];
  
  b = fir2(order,freq,ampl);

end;
