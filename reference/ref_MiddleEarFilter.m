% Make a filter to apply a headphone and outer ear transfer function to the input
% generate filter (.mat file) by running this once
% Morten Løve Jepsen, 16.nov 2005

function stapes_data = MiddleEarFilter(fs)

order = 512;    % desired FIR filter order

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

%stapes_data = dlmread('Human_stapes.txt', '\t'); % middle ear impedance
stapes_data (:,2) = 1./stapes_data(:,2); % IMPORTANT: need to find inverse because 
                            % original data is stapes impedance and we need stapes velocity.
mid_ear_fir_coeff = fir2_fromXYtable(order, stapes_data, fs, 'amp');
mid_ear_fir_coeff = mid_ear_fir_coeff/max(abs(fft(mid_ear_fir_coeff)))*1e-8*10^(104/20); % se figurtekst 1, lopez 2001 
save MiddleFIR.mat mid_ear_fir_coeff

%b = mid_ear_fir_coeff;
% y = filter(b,1,x);





