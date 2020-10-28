function   rm_baseline(pathname, fName, fileNameSet,saveDirPath)
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
%L
EEG = pop_epoch( EEG, {  '22'  }, [-1.93      3.99], 'newname', strcat(fName,'_L'), 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(fName,'_L'),'savenew',strcat(saveDirPath,'\',fName,'_L','.set'),'gui','off'); 
EEG = eeg_checkset( EEG );

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );

%R
EEG = pop_epoch( EEG, {  '23'  }, [-1.93      3.99], 'newname', strcat(fName,'_R'), 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(fName,'_R'),'savenew',strcat(saveDirPath,'\',fName,'_R','.set'),'gui','off'); 
EEG = eeg_checkset( EEG );

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );

%Rest
EEG = pop_epoch( EEG, {  '24'  }, [-1.93      3.99], 'newname', strcat(fName,'_Rest'), 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(fName,'_Rest'),'savenew',strcat(saveDirPath,'\',fName,'_Rest','.set'),'gui','off'); 
EEG = eeg_checkset( EEG );


