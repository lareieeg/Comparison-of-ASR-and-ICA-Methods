function   rm_baseline(pathname, fName, fileNameSet,saveDirPath)
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
%krzyzyki
EEG = pop_epoch( EEG, {  '11'  }, [-0.1         0.6], 'newname', strcat(fName,'_X'), 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(fName,'_X'),'savenew',strcat(saveDirPath,'\',fName,'_X','.set'),'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-100    0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname',strcat(fName,'_X'),'savenew',strcat(saveDirPath,'\',fName,'_X','.set'),'gui','off'); 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
%kolka
EEG = pop_epoch( EEG, {  '12'  }, [-0.1         0.6], 'newname', strcat(fName,'_O'), 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(fName,'_O'),'savenew',strcat(saveDirPath,'\',fName,'_O','.set'),'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-100    0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname',strcat(fName,'_O'),'savenew',strcat(saveDirPath,'\',fName,'_O','.set'),'gui','off'); 
