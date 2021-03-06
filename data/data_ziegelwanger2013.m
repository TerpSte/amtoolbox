function data = data_ziegelwanger2013(varargin)
%DATA_ZIEGELWANGER2013  Data from Ziegelwanger and Majdak (2013)
%   Usage: data = data_ziegelwanger2013(flag)
%
%   `data_ziegelwanger2013(flag)` returns results for different HRTF
%   databases from Ziegelwanger and Majdak (2013).
%
%   The flag may be one of:
%  
%     'ARI'         ARI database. The output has the following
%                   fields: `data.results` and `data.subjects`.
%  
%     'CIPIC'       CIPIC database. The output has the following fields: 
%                   `data.results` and `data.subjects`.
%  
%     'LISTEN'      LISTEN database. The output has the following fields.
%                   `data.results` and `data.subjects`.
%  
%     'SPHERE_ROT'  HRTF sets for a rigid sphere placed in the center of
%                   the measurement setup and varying rotation. The
%                   output has the following fields: `data.results`,
%                   `data.subjects`, `data.phi`, `data.theta` and `data.radius`.
%  
%     'SPHERE_DIS'  HRTF sets for a rigid sphere with various positions in
%                   the measurement setup. The output has the following fields: 
%                   `data.results`, `data.subjects`, `data.xM`, `data.yM`,
%                   `data.zM` and `data.radius`.
%  
%     'NH89'        HRTF set of listener NH89 of the ARI database: The
%                   output has the following fields: `data.hM`,
%                   `data.meta` and `data.stimPar`.
%  
%     'cached'      Reload previously calculated results from the cache
%  
%     'redo'        Recalculate the results
%
%   The fields are given by:
%
%     `data.results`     Results for all HRTF sets
%
%     `data.subjects`    IDs for HRTF sets
%
%     `data.phi`         Azimuth of ear position
%
%     `data.theta`       Elevation of ear position
%
%     `data.radius`      sphere radius
%
%     `data.xM`          x-coordinate of sphere center
%
%     `data.yM`          y-coordinate of sphere center
%
%     `data.zM`          z-coordinate of sphere center
%
%     `data`             SOFA object
%
%   Requirements: 
%   -------------
%
%   1) SOFA API from http://sourceforge.net/projects/sofacoustics for Matlab (in e.g. thirdparty/SOFA)
% 
%   2) Optimization Toolbox for Matlab
%
%   3) Data in hrtf/ziegelwanger2013
% 
%   Examples:
%   ---------
% 
%   To get results from the ARI database, use::
%
%     data=data_ziegelwanger2013('ARI');
%
%   See also: ziegelwanger2013, ziegelwanger2013onaxis,
%   ziegelwanger2013offaxis, exp_ziegelwanger2013
%
%   References: ziegelwanger2013 majdak2013toa

% Explain Data in description

% AUTHOR: Harald Ziegelwanger, Acoustics Research Institute, Vienna,
% Austria

%% ------ Check input options --------------------------------------------

% Define input flags
definput.import={'amtcache'}; % get the flags of amtcache
definput.flags.type = {'missingflag','ARI','CIPIC','LISTEN','SPHERE_DIS','SPHERE_ROT','NH89'};

% Parse input options
[flags,keyvals]  = ltfatarghelper({},definput,varargin);

if flags.do_missingflag
    flagnames=[sprintf('%s, ',definput.flags.type{2:end-2}),...
        sprintf('%s or %s',definput.flags.type{end-1},definput.flags.type{end})];
    error('%s: You must specify one of the following flags: %s.',upper(mfilename),flagnames);
end


%% ARI database
if flags.do_ARI
    
    tmp=amtload('ziegelwanger2013','info.mat');
    data=tmp.info.ARI;
    results=amtcache('get','ARI',flags.cachemode);
    if isempty(results)
        for ii=1:length(data.subjects)
            Obj=SOFAload(fullfile(SOFAdbPath, 'ziegelwanger2013', ['ARI_' data.subjects{ii} '.sofa']));
            idx=find(mod(Obj.SourcePosition(:,2),10)==0);
            Obj.Data.IR=Obj.Data.IR(idx,:,:);
            Obj.SourcePosition=Obj.SourcePosition(idx,:);
            Obj.MeasurementSourceAudioChannel=Obj.MeasurementSourceAudioChannel(idx,:);
            Obj.MeasurementAudioLatency=Obj.MeasurementAudioLatency(idx,:);
            Obj.API.M=length(idx);
            amtdisp(['Calculating TOA models from the ARI database, ' data.subjects{ii} ' (' num2str(ii) '/' num2str(length(data.subjects)) ')'],'progress');
            [Obj,tmp]=ziegelwanger2013(Obj,4,1);
            results(ii).meta=tmp;
            results(ii).meta.performance(4)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,1,0);
            results(ii).meta.performance(1)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,2,0);
            results(ii).meta.performance(2)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,3,0);
            results(ii).meta.performance(3)=tmp.performance;
            clear hM; clear meta; clear stimPar;
        end
        amtcache('set','ARI',results);
    end
    data.results=results;
    
end

%% CIPIC database
if flags.do_CIPIC
    
    tmp=amtload('ziegelwanger2013','info.mat');
    data=tmp.info.CIPIC;
    results=amtcache('get','CIPIC',flags.cachemode);
    if isempty(results)
        for ii=1:length(data.subjects)
            Obj=SOFAload(fullfile(SOFAdbPath, 'ziegelwanger2013', ['CIPIC_' data.subjects{ii} '.sofa']));
            amtdisp(['Calculating TOA models from the CIPIC database, ' data.subjects{ii} ' (' num2str(ii) '/' num2str(length(data.subjects)) ')'],'progress');            
            [Obj,tmp]=ziegelwanger2013(Obj,4,1);
            results(ii).meta=tmp;
            results(ii).meta.performance(4)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,1,0);
            results(ii).meta.performance(1)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,2,0);
            results(ii).meta.performance(2)=tmp.performance;
            [~,tmp]=ziegelwanger2013(Obj,3,0);
            results(ii).meta.performance(3)=tmp.performance;
            clear hM; clear meta; clear stimPar;
        end
        amtcache('set','CIPIC',results);      
    end
    data.results=results;    
end

%% LISTEN database
if flags.do_LISTEN
    
    tmp=amtload('ziegelwanger2013','info.mat');
    data=tmp.info.LISTEN;
    results=amtcache('get','LISTEN',flags.cachemode);
    if isempty(results)
        for ii=1:length(data.subjects)
            if ~strcmp(data.subjects{ii},'34')
                Obj=SOFAload(fullfile(SOFAdbPath, 'ziegelwanger2013', ['LISTEN_' data.subjects{ii} '.sofa']));
                Obj.Data.SamplingRate=48000;
                amtdisp(['Calculating TOA models from the LISTEN database, ' data.subjects{ii} ' (' num2str(ii) '/' num2str(length(data.subjects)) ')'],'progress');                            
                [Obj,tmp]=ziegelwanger2013(Obj,4,1);
                results(ii).meta=tmp;
                results(ii).meta.performance(4)=tmp.performance;
                [~,tmp]=ziegelwanger2013(Obj,1,0);
                results(ii).meta.performance(1)=tmp.performance;
                [~,tmp]=ziegelwanger2013(Obj,2,0);
                results(ii).meta.performance(2)=tmp.performance;
                [~,tmp]=ziegelwanger2013(Obj,3,0);
                results(ii).meta.performance(3)=tmp.performance;
                clear hM; clear meta; clear stimPar;
            end
        end
        amtcache('set','LISTEN',results);      
    end
    data.results=results;    
end

%% SPHERE (Displacement) database
if flags.do_SPHERE_DIS
    
    tmp=amtload('ziegelwanger2013','info.mat');
    data=tmp.info.Displacement;
    results=amtcache('get','SPHERE_DIS',flags.cachemode);
    if isempty(results)
        results.p_onaxis=zeros(4,2,length(data.subjects));
        results.p_offaxis=zeros(7,2,length(data.subjects));
        for ii=1:length(data.subjects)
            Obj=SOFAload(fullfile(SOFAdbPath, 'ziegelwanger2013', ['Sphere_Displacement_' data.subjects{ii} '.sofa']));
            amtdisp(['Calculating TOA models for displaced SPHERE, ' data.subjects{ii} ' (' num2str(ii) '/' num2str(length(data.subjects)) ')'],'progress');                        
            [~,tmp]=ziegelwanger2013(Obj,4,1);
            results.p_onaxis(:,:,ii)=tmp.p_onaxis;
            results.p_offaxis(:,:,ii)=tmp.p_offaxis;
        end
        amtcache('set','SPHERE_DIS',results);      
    end
    data.results=results;        
end

%% SPHERE (Rotation) database
if flags.do_SPHERE_ROT
    
    tmp=amtload('ziegelwanger2013','info.mat');
    data=tmp.info.Rotation;
    results=amtcache('get','SPHERE_ROT',flags.cachemode);
    if isempty(results)
        results.p=zeros(4,2,length(data.phi));
        for ii=1:length(data.subjects)
            Obj=SOFAload(fullfile(SOFAdbPath, 'ziegelwanger2013', ['Sphere_Rotation_' data.subjects{ii} '.sofa']));
            amtdisp(['Calculating TOA models for rotated SPHERE, ' data.subjects{ii} ' (' num2str(ii) '/' num2str(length(data.subjects)) ')'],'progress');                        
            [~,tmp]=ziegelwanger2013(Obj,4,1);
            results.p_onaxis(:,:,ii)=tmp.p_onaxis;
        end
        amtcache('set','SPHERE_ROT',results);      
    end
    data.results=results;    
end

%% ARI database (NH89)
if flags.do_NH89
    
    data=SOFAload(fullfile(SOFAdbPath, 'ziegelwanger2013', 'ARI_NH89.sofa'));
    
end