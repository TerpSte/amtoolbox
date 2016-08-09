function definput=arg_localizationerror(definput)

definput.flags.errorflag = {'','accL','precL','precLcentral',...
  'accP','precP','querr',...
  'accE','absaccE','precE','accE',...
  'absaccL','accabsL','accPnoquerr','querr90','precPmedian',...
  'precPmedianlocal','precPnoquerr',...
  'rmsL','rmsPmedianlocal','rmsPmedian',...
  'querrMiddlebrooks','corrcoefL','corrcoefP','SCC',...
  'gainLstats','gainL','pVeridicalL','precLregress'...
  'sirpMacpherson2000','perMacpherson2003',...
  'gainPfront','gainPrear','gainP',...
  'slopePfront','slopePrear','slopeP',...
  'pVeridicalPfront','pVeridicalPrear','pVeridicalP',...
  'precPregressFront','precPregressRear','precPregress'};
definput.keyvals.f=[];       % regress structure of frontal hemisphere
definput.keyvals.r=[];       % regress structure of rear hemisphere

end