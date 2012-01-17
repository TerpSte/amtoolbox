function data = data_langendijk2002(flag)
%DATA_LANGENDIJK2002  Data from Langendijk & Bronkhorst (2002)
%   Usage: data = data_langendijk2002(flag)
%
%   Output parameters:
%      data  : The data points from the given figure;
%
%   `data_langendijk2002(flag)` returns data points from the paper by 
%   Langendijk & Bronkhorst (2002). 
%
%   In the case of response patterns (Fig. 7 & 9) the first row of *data*
%   describes target position and the second one belongs to the response
%   position.  In the case of DTF data (Fig. 11) the first dimension of the
%   *data* matrix describes frequency and the second one angle position, the
%   **first column** defines the actual angle positions.
%
%   The flag may be one of:
%
%     'P3-b'     Data from Fig.9; listener: P3, condition: 'baseline'.
%              
%     'P3-2o'    Data from Fig.9; listener: P3, condition: '2-oct'.
%              
%     'P3-1ol'   Data from Fig.9; listener: P3, condition: '1-oct(low)'.
%              
%     'P3-1om'   Data from Fig.9; listener: P3, condition: '1-oct(middle)'.
%              
%     'P3-1oh'   Data from Fig.9; listener: P3, condition: '1-oct(high)'.
%              
%     'P6-b'     Data from Fig.9; listener: P6, condition: 'baseline'.
%              
%     'P6-2o'    Data from Fig.9; listener: P6, condition: '2-oct'.
%              
%     'P6-1ol'   Data from Fig.9; listener: P6, condition: '1-oct(low)'.
%              
%     'P6-1om'   Data from Fig.9; listener: P6, condition: '1-oct(middle)'.
%              
%     'P6-1oh'   Data from Fig.9; listener: P6, condition: '1-oct(high)'.
%              
%     'P3-dtf'   DTF data from Fig.11; listener: P3. If you do not have the
%                bitmap of the JASA paper you will get the precalculated
%                gain response data hrtf_M_langendijk2002 P3.ampMdB.
%              
%     'P6-dtf'   DTF data from Fig.11; listener: P6. If you do not have the
%                bitmap of the JASA paper you will get the precalculated
%                gain response data hrtf_M_langendijk2002 P6.ampMdB.
%
%     'expdata'  Create the whole dataset required for exp_langendijk2002,
%                e.g. after adjusting response data.
%                **BE ADVISED**: The calculation takes a long time.
%                If only parts of data (e.g. '1-oct(high)') are to be
%                regenerated, the unnecessary parts can be commented out to
%                save computation time.
%
%   If no flag is given, the function will print the list of valid flags.
%
%   References: langendijk2002contribution
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR : Robert Baumgartner, OEAW Acoustical Research Institute
% latest update: 2010-08-19
% Bugfixes and minor adjustments: Sebastian Grill 2011-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

target=-55:29:235;
idb=round(0.5:0.1:11.4);
idc=round(0.5:0.2:11.4);
if ~exist('flag','var')
    disp('You must specify one of the following flags: P3-b,P3-2o,P3-1ol,P3-1om,P3-1oh,P6-b,P6-2o,P6-1ol,P6-1om,P6-1oh,P3-dtf,P6-dtf,expdata')
else    
    switch flag
        case 'P3-b'
            target=target(idb);
            response=zeros(1,110);
            response(1:10) =[-55,-55,-55,-55,-55,-55,-53,-54,-45,-45];
            response(11:20)=[-55,-40,-38,-34,-30,-29,-28,-22,-25,-15];
            response(21:30)=[-12,00,03,05,09,15,20,24,30,140];
            response(31:40)=[21,29,31,32,34,45,58,75,110,122];
            response(41:50)=[118,119,123,134,135,140,163,174,176,210];
            response(51:60)=[106,107,123,124,137,162,183,210,219,225];
            response(61:70)=[-55,95,113,119,120,121,126,161,181,214];
            response(71:80)=[119,130,142,143,170,184,190,199,225,235];
            response(81:90)=[146,153,154,155,157,161,180,181,181,210];
            response(91:100)=[93,94,170,180,182,183,184,191,230,231];
            response(101:110)=[230,231,235,235,235,235,235,235,235,234];
            data=[target;response];
        case 'P3-2o'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-45,-12,165,181,182];
            response(6:10) =[-53,-30,-12,-11,192];
            response(11:15)=[-20,128,141,170,213];
            response(16:20)=[-55,-54,130,175,204];
            response(21:25)=[-30,72,172,180,202];
            response(26:30)=[164,181,219,235,234];
            response(31:35)=[-55,108,184,210,235];
            response(36:40)=[116,182,183,184,210];
            response(41:45)=[113,165,180,181,225];
            response(46:50)=[-54,-41,134,169,184];
            response(51:55)=[-55,234,234,235,235];
            data=[target;response];
        case 'P3-1ol'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-54,-50,-49,-35,-30];
            response(6:10) =[-40,-37,-30,-23,-12];
            response(11:15)=[-25,-17,-3,5,13];
            response(16:20)=[-37,40,39,108,110];
            response(21:25)=[148,161,174,175,190];
            response(26:30)=[-50,-35,103,150,176];
            response(31:35)=[125,126,130,147,168];
            response(36:40)=[-55,110,167,168,175];
            response(41:45)=[144,152,154,180,190];
            response(46:50)=[173,179,180,215,225];
            response(51:55)=[-55,235,234,235,235];
            data=[target;response];
        case 'P3-1om'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-55,-55,-54,-50,-48];
            response(6:10) =[-35,-28,-27,-25,-24];
            response(11:15)=[-51,-48,-25,-23,-18];
            response(16:20)=[-55,112,210,234,235];
            response(21:25)=[122,122,160,172,185];
            response(26:30)=[122,138,208,213,223];
            response(31:35)=[122,163,176,219,235];
            response(36:40)=[-55,-54,177,234,235];
            response(41:45)=[-55,128,163,180,224];
            response(46:50)=[-55,-54,150,151,183];
            response(51:55)=[-55,-54,228,234,235];
            data=[target;response];
        case 'P3-1oh'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-55,-54,-50,-42,235];
            response(6:10) =[-55,-50,-40,-22,175];
            response(11:15)=[-29,3,60,145,150];
            response(16:20)=[14,130,166,168,180];
            response(21:25)=[40,122,123,148,180];
            response(26:30)=[122,123,128,208,215];
            response(31:35)=[119,133,138,145,175];
            response(36:40)=[122,175,180,181,182];
            response(41:45)=[110,175,175,176,190];
            response(46:50)=[-55,174,184,200,201];
            response(51:55)=[234,234,235,235,235];
            data=[target;response];
        case 'P6-b'
            target=target(idb);
            response=zeros(1,110);
            response(1:10) =[-55,-55,-55,-55,-55,-55,-55,-55,-55,-55];
            response(11:20)=[-50,-46,-41,-35,-36,-31,-32,-30,-25,-10];
            response(21:30)=[-25,-13,-8,-1,0,1,3,5,5,10];
            response(31:40)=[15,20,28,28,29,31,33,33,36,50];
            response(41:50)=[55,55,60,64,73,74,80,82,85,95];
            response(51:60)=[90,90,91,93,94,100,101,103,120,130];
            response(61:70)=[70,77,90,90,91,100,105,130,130,131];
            response(71:80)=[-50,-50,-40,0,95,100,101,105,162,167];
            response(81:90)=[145,146,150,160,165,169,170,171,180,181];
            response(91:100)=[185,186,195,196,200,209,210,211,215,220];
            response(101:110)=[210,215,220,225,230,231,235,235,234,234];
            data=[target;response];
        case 'P6-2o'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-55,-54,-30,110,165];
            response(6:10) =[-55,-45,-40,-35,-20];
            response(11:15)=[-50,-35,-25,-20,125];
            response(16:20)=[-55,-50,-30,-31,180];
            response(21:25)=[-45,125,145,180,185];
            response(26:30)=[-55,-45,-30,-15,140];
            response(31:35)=[-55,-50,-45,-44,-20];
            response(36:40)=[-45,-40,-41,-35,170];
            response(41:45)=[-50,-35,100,180,181];
            response(46:50)=[-55,-54,-50,-45,140];
            response(51:55)=[-55,-55,-54,-54,-53];
            data=[target;response];
        case 'P6-1ol'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-55,-54,-53,-49,-50];
            response(6:10) =[-35,-34,-30,-20,-19];
            response(11:15)=[-25,-10,-9,-11,5];
            response(16:20)=[25,30,31,35,40];
            response(21:25)=[65,70,95,96,100];
            response(26:30)=[60,85,90,91,110];
            response(31:35)=[75,85,90,100,105];
            response(36:40)=[-35,-25,-26,-20,80];
            response(41:45)=[0,185,184,186,190];
            response(46:50)=[175,195,205,210,215];
            response(51:55)=[225,230,233,234,235];
            data=[target;response];
        case 'P6-1om'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-55,-54,-55,-54,-50];
            response(6:10) =[-55,-45,-44,-46,-35];
            response(11:15)=[-15,-10,5,6,10];
            response(16:20)=[5,15,20,30,31];
            response(21:25)=[45,60,61,65,66];
            response(26:30)=[-45,60,100,120,121];
            response(31:35)=[-55,80,105,175,176];
            response(36:40)=[-50,-40,-41,-10,10,];
            response(41:45)=[-55,-54,-50,-30,195];
            response(46:50)=[-50,100,105,106,135];
            response(51:55)=[-55,-55,-54,-54,235];
            data=[target;response];
        case 'P6-1oh'
            target=target(idc);
            response=zeros(1,55);
            response(1:5)  =[-55,-54,-55,-54,-35];
            response(6:10) =[-55,-54,-50,-51,-35];
            response(11:15)=[-15,-11,-10,-9,-5];
            response(16:20)=[10,25,35,55,105];
            response(21:25)=[40,45,50,51,75];
            response(26:30)=[-10,70,72,80,102];
            response(31:35)=[90,95,100,101,105];
            response(36:40)=[-55,-25,40,105,145];
            response(41:45)=[-55,-50,-45,-30,-25];
            response(46:50)=[-35,-34,-5,162,180];
            response(51:55)=[-55,-50,-54,235,234];
            data=[target;response];
        case 'P3-dtf'
            if exist('langendijk2002-dtfP3.bmp','file')==2
                [med,pol]=bmp2gr('langendijk2002-dtfP3');
                data=[pol;med];
            else
                data=load('hrtf_M_langendijk2002 P3');
            end
        case 'P6-dtf'
            if exist('langendijk2002-dtfP6.bmp','file')==2
                [med,pol]=bmp2gr('langendijk2002-dtfP6');
                data=[pol;med];
            else
                data=load('hrtf_M_langendijk2002 P6');
            end
        case 'expdata'
            clear
            listener='P3';
            temp=data_langendijk2002([listener '-dtf']);
            fs=temp.stimPar.SamplingRate;           
            pol=temp.posLIN(:,5)';
            temp=temp.ampMdB;
            med=temp(1:end,:);
            temp=data_langendijk2002([listener '-b']);
            targetb=temp(1,:); responseb=temp(2,:);
            h = waitbar(0,'Please wait...1/2');
            medir=gr2ir(med,'b',fs);
            temp=data_langendijk2002([listener '-2o']);
            targetc=temp(1,:); response2o=temp(2,:);
            waitbar(1/5);
            medir2o=gr2ir(med,'2o',fs);
            temp=data_langendijk2002([listener '-1ol']);
            response1ol=temp(2,:);
            waitbar(2/5);
            medir1ol=gr2ir(med,'1ol',fs);
            temp=data_langendijk2002([listener '-1om']);
            response1om=temp(2,:);
            waitbar(3/5);
            medir1om=gr2ir(med,'1om',fs);
            temp=data_langendijk2002([listener '-1oh']);
            response1oh=temp(2,:);
            waitbar(4/5);
            medir1oh=gr2ir(med,'1oh',fs);
            save(['humandata\langendijk2002-' listener '.mat'],'-append','-regexp','^med|^pol|^response|^target');
            waitbar(5/5);
            close(h);
            
            clear
            listener='P6';
            temp=data_langendijk2002([listener '-dtf']);
            fs=temp.stimPar.SamplingRate;
            pol=temp.posLIN(:,5)';
            temp=temp.ampMdB;
            med=temp(1:end,:);
            temp=data_langendijk2002([listener '-b']);
            targetb=temp(1,:); responseb=temp(2,:);
            h = waitbar(0,'Please wait...2/2');
            medir=gr2ir(med,'b',fs);
            temp=data_langendijk2002([listener '-2o']);
            targetc=temp(1,:); response2o=temp(2,:);
            waitbar(1/5);
            medir2o=gr2ir(med,'2o',fs);
            temp=data_langendijk2002([listener '-1ol']);
            response1ol=temp(2,:);
            waitbar(2/5);
            medir1ol=gr2ir(med,'1ol',fs);
            temp=data_langendijk2002([listener '-1om']);
            response1om=temp(2,:);
            waitbar(3/5);
            medir1om=gr2ir(med,'1om',fs);
            temp=data_langendijk2002([listener '-1oh']);
            response1oh=temp(2,:);
            waitbar(4/5);
            medir1oh=gr2ir(med,'1oh',fs);
            save(['humandata\langendijk2002-' listener '.mat'],'-append','-regexp','^med|^pol|^response|^target');
            waitbar(5/5);
            close(h);
        otherwise
            disp('You must specify one of the following flags: P3-b,P3-2o,P3-1ol,P3-1om,P3-1oh,P6-b,P6-2o,P6-1ol,P6-1om,P6-1oh,P3-dtf,P6-dtf,expdata')
    end
end
end       
            
function [med,pol]=bmp2gr(bmpname)
% BMP2GR converts a bitmap to gain response data (in dB) with conditions
% Usage:  [med,pol]=bmp2gr(bmpname)
% Input arguments:
%       bmpname:    filename of bitmap
% Output arguments:
%       medir:   	gain response data (in dB) on median plane for 
%                   53 polar angles defined in pol
%       pol:     	53 equally spaced polar angles between -55� and 235�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR : Robert Baumgartner, OEAW Acoustical Research Institute
% latest update: 2010-08-16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bmp=imread(bmpname,'bmp');
hrtf=zeros(size(bmp,2),size(bmp,1));

sq=4;
for jj=1:size(hrtf,2)
    if jj<=sq || jj>=size(hrtf,2)-sq
        av=0;
    else
        av=sq;
    end
    for ii=1:size(hrtf,1)
        temp=mean(bmp(end-jj+1-av:end-jj+1+av,ii,1));
        if temp<=25 && temp >=15
            hrtf(ii,jj)=-15;
        elseif temp<=50 && temp>40
            hrtf(ii,jj)=-10;
        elseif temp<=85 && temp>65
            hrtf(ii,jj)=-5;
        elseif temp<=150 && temp>120
            hrtf(ii,jj)=0;
        elseif temp<=185 && temp>160
            hrtf(ii,jj)=5;
        elseif temp<=210 && temp>199
            hrtf(ii,jj)=10;
        elseif temp>220
            hrtf(ii,jj)=15;
        else
            if ii==1
                hrtf(ii,jj)=0;
            else
                hrtf(ii,jj)=hrtf(ii-1,jj);
            end
        end
    end
end

sq=3;
for jj=1:size(hrtf,2)
    if jj<=sq || jj>=size(hrtf,2)-sq
        av=0;
    else
        av=sq;
    end
    for ii=1:size(hrtf,1)
        hrtf(ii,jj)=mean(hrtf(ii,jj-av:jj+av));
    end
end

% figure; pcolor(hrtf'),shading flat
posidx=5:9:475;
pol=-55:290/52:235;
med=hrtf(:,posidx);
% figure; pcolor(med'),shading flat

end

function [medir]=gr2ir(med,cond,fs)
% GR2IR converts given gain responses MED (in dB) to impulse responses
% MEDIR; furthermore several conditions according to langendijk et al.
% (2002) can be defined
% Usage:            [medir]=gr2ir(med,cond,fs)
% Input arguments:
%       med:        gain responses (in dB)
%       cond:       condition, 
%                   possibilities:  baseline    'b'
%                                   2 octaves   '2o'
%                                   1 oct (low) '1ol'
%                                   1 oct (mid) '1om'
%                                   1 oct (high)'1oh'
%       fs:      	sampling frequency
% Output arguments:
%       medir:   	impulse responses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR : Robert Baumgartner, OEAW Acoustical Research Institute
% latest update: 2010-08-16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default settings
if ~exist('cond','var')
    cond='b';
end
if ~exist('fs','var')
    fs=48000;
end

imp=zeros(240,1);imp(1)=1;
n=256;
len=240;
frq=logspace(log10(2000),log10(16000),size(med,1));

% frequency indices
f1=find(frq>=4000,1);
f2=find(frq>=5700,1);
f3=find(frq>=8000,1);
f4=find(frq>=11300,1);

switch cond
    case 'b' % baseline
        medir=zeros(n,size(med,2));
        for ii=1:size(med,2)
            bp = firls(len,[0 0.08 frq/(fs/2) 0.68 1],[0;0; 10.^(med(:,ii)/20); 0;0]);
            medir(1:length(imp),ii) = filter(bp,1,imp);
        end

    case '2o' % 2 oct (4-16kHz)
        medir=zeros(n,size(med,2));
        med2o=med;
        for ii=1:size(med,2)
            med2o(f1:end,ii)=mean(med(f1:end,ii));
            bp = firls(len,[0 0.08 frq/(fs/2) 0.68 1],[0;0; 10.^(med2o(:,ii)/20); 0;0]);
            medir(1:length(imp),ii) = filter(bp,1,imp);
        end

    case '1ol' % 1 oct (low:4-8kHz)
        medir=zeros(n,size(med,2));
        med1ol=med;
        for ii=1:size(med,2)
            med1ol(f1:f3,ii)=mean(med(f1:f3,ii));
            bp = firls(len,[0 0.08 frq/(fs/2) 0.68 1],[0;0; 10.^(med1ol(:,ii)/20); 0;0]);
            medir(1:length(imp),ii) = filter(bp,1,imp);
        end

    case '1om' % 1 oct (middle:5.7-11.3kHz)
        medir=zeros(n,size(med,2));
        med1om=med;
        for ii=1:size(med,2)
            med1om(f2:f4,ii)=mean(med(f2:f4,ii));
            bp = firls(len,[0 0.08 frq/(fs/2) 0.68 1],[0;0; 10.^(med1om(:,ii)/20); 0;0]);
            medir(1:length(imp),ii) = filter(bp,1,imp);
        end

    case '1oh' % 1 oct (high:8-16kHz)
        medir=zeros(n,size(med,2));
        med1oh=med;
        for ii=1:size(med,2)
            med1oh(f3:end,ii)=mean(med(f3:end,ii));
            bp = firls(len,[0 0.08 frq/(fs/2) 0.68 1],[0;0; 10.^(med1oh(:,ii)/20); 0;0]);
            medir(1:length(imp),ii) = filter(bp,1,imp);
        end
end
end