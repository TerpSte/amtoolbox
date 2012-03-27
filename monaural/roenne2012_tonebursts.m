function [waveVlat]  = roenne2012_tonebursts(stim_level,varargin)
%ROENNE2012_TONEBURSTS  Simulate tone burst evoked ABR wave V latencies
%   Usage: [waveVamp, waveVlat]  = roenne2012_tonebursts(flag)
%
%   Output parameters:
%     waveVlat   : Latency of simulated ABR wave V peak.
%
%   `roenne2012_tonebursts(stim_level)` simulates ABR responses to tone burst
%   stimuli using the ABR model of R�nne et al. (2012) for a range of
%   given stimulus levels.
%
%   Fig. 5 of R�nne et al. (2012) can be reproduced. Simulations are
%   compared to data from Neely et al. (1988) and Harte et al. (2009). Tone
%   burst stimuli are defined similar to Harte et al. (2009). Tone burst
%   center frequencies are: 1, 1.5, 2, 3, 6 and 8 kHz.
%
%   The flag may be one of:
%
%     'plot'    Plot main figure (fig 6 or 7).
%
%     'plot2'   Plot extra figures for all individual simulations (3
%               figures x stimulus levels x number of chirps).
%
%     'noplot'  Do not plot main figure (fig 6 or 7). This is the default.
%
%     'fig5'    Plot Fig. 5 (R�nne et al., 2012). Latency of simulated ABR
%               wave V's compared to Neely et al. (1988) and Harte et al.
%               (2009) reference data.
%
%     'stim_level',sl  Simulated levels. Default: Stimulus levels as
%                      chosen by R�nne et al. (2012), 40 to 100 dB pe SPL
%                      in steps of 10 dB. 
%
%   Example:
%   --------
%
%   Figure 5 of Roenne et al. (2012) can be displayed using::
%
%     roenne2012_tonebursts(40:10:100,'plot');
%
%   References: roenne2012modeling elberling2010evaluating harte2009comparison zilany2007representation

definput.flags.plot={'noplot','plot','plot2'};
[flags,kv]  = ltfatarghelper({},definput,varargin);

%% Init
fsstim   = 48000;       % stimulus fs
fsmod    = 200000;      % AN model fs

% length of modelling [ms]
modellength  = 40;                                                   

% load Unitary Response
[ur,fs]=data_roenne2012;

% Output filter corresponding to recording settings (see Elberling et al
% 2010 section 3)
b=fir1(200,[100/(fs/2),3000/(fs/2)]);
a=1;

% Center Frequencies of stimuli
CF = [1000, 1500, 2000, 3000 ,6000, 8000];                 


% Load tone burst stimuli, identical to Harte et al. (2009)
[Hartestim,fs]  = data_harte2009;

%% ABR model

% Loop over stimulus levels
for L = 1:length(stim_level)
  TB_lvl = stim_level(L);
  
  % Loop over stimulus center frequencis
  for F = 1:length(CF) 
    
    % Read tone burst of current CF
    stimread=Hartestim.(['gp' num2str(CF(F))]);
    stim                = zeros(fsstim*modellength/1000,1);     
    
    % Create stimulus with tone burst and concatenated zeros =>
    % combined length = "modellength"
    stim(1:length(stimread)) = stimread;                                
    
    % call AN model, note that lots of extra outputs are possible - see
    % "roenne2012_get_an.m"
    [ANout,vFreq] = zilany2007humanized(TB_lvl, stim, fsstim,fsmod);    
    
    % subtract 50 due to spontaneous rate
    ANout = ANout-50;                                     
    
    % Sum in time across fibers, summed activity pattern
    ANsum = sum(ANout',2);                                
    
    % Downsample ANsum to get fs = fs_UR = 30kHz
    ANsum = resample(ANsum,fs,fsmod);                     
    
    % Simulated potential = UR * ANsum (* = convolved)
    simpot = filter(ur,1,ANsum);                           
    
    % apply output filter similar to the recording conditions in
    % Elberling et al. (2010)
    simpot = filtfilt(b,a,simpot);                         
    
    % Find max peak value (wave V)
    maxpeak  = max(simpot);                                  
    
    % Find corresponding time of max peak value (latency of wave V)
    waveVlat(F,L) = find(simpot == maxpeak);                 
    
    %% PLOTS, extra plots created for all conditions used, i.e. three
    % plots for each stimulus level x center frequency. If this
    % is switched on and all other variables are set to default,
    % 7 (levels) x 6 (CFs) x 3 (different figures) = 126 figures will
    % be created
    if flags.do_plot2     
      % Plot ABR (simpot)
      t = 1e3.*[0:length(simpot)-1]./fs;
      figure, plot(t-3.5,simpot,'k','linewidth',2)
      xlabel('time [ms]'), set(gca, 'fontsize',12)
      title(['Simulated ABR ( ' num2str(CF(F)) 'Hz,' num2str(TB_lvl) 'dB)'])
      
      % PLOT ANgram
      figure,  set(gca, 'fontsize',12),imagesc(ANout), 
      title(['ANgram, level = ' num2str(TB_lvl) 'dB, CF = ' num2str(CF(F))])
      ylabel('model CF'),xlabel('time [ms]'), xlabel('time [ms]')
      set(gca,'YTick',[1 100 200 300 400 500]),
      set(gca,'YTicklabel',round(vFreq([1 100 200 300 400 500])))
      set(gca,'XTick',(700:500:10000)),
      set(gca,'XTicklabel',(0:500:9500)/fsmod*1000-3.5)
      colorbar
      
      % PLOT ANURgram
      figure,
      ANUR = resample(ANout',fs,fsmod);
      ANUR = filter(ur,1,ANUR);
      imagesc(ANUR'),ylabel('model CF'),
      set(gca,'YTick',[1 100 200 300 400 500]),xlabel('time [ms]'),
      set(gca,'YTicklabel',round(vFreq([1 100 200 300 400 500]))), 
      set(gca,'XTick',(105:150:1500)),
      set(gca,'XTicklabel',(0:150:1350)/fs*1000-3.5)
      colorbar, title(['AN-UR gram, level = ' num2str(TB_lvl) 'dB, CF = ' num2str(CF(F))])
      
    end
  end
end

offset      = 3.5 ;        % stimuli delayed 3.5ms from start
waveVlat    = waveVlat*1000/fs-offset;

if flags.do_plot
  
  ClickLatency = roenne2012_click(stim_level); 
  
  figure;
  plotroenne2012_toneburst(waveVlat,click_latency);
  
end