function eegplugin_pca( fig, try_strings, catch_strings);
 
% create menu
toolsmenu = findobj(fig, 'tag', 'tools');
submenu = uimenu( toolsmenu, 'label', 'Run PCA');
 
% build command for menu callback\\ 
cmd = [ '[tmp1 EEG.icawinv] = runpca(EEG.data(:,:));' ]; 
cmd = [ cmd 'EEG.icaweights = pinv(EEG.icawinv);' ]; 
cmd = [ cmd 'EEG.icasphere = eye(EEG.nbchan);' ];
cmd = [ cmd 'clear tmp1;' ];
 
finalcmd = [ try_strings.no_check cmd ]; 
finalcmd = [ finalcmd 'LASTCOM = ''' cmd ''';' ]; 
finalcmd = [ finalcmd catch_strings.store_and_hist ]; 
 
% add new submenu
uimenu( submenu, 'label', 'Run PCA', 'callback', finalcmd);