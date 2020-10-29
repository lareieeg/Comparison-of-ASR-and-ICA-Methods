epoki=[];
%nazwy_plikow=[1102 1103 1106 1107 1109 1110 1111 1119 1205 1208 ];
nazwy_plikow=[1103 1106 1107 1109 1110 1111 1119];
for i=1:1:7
nazwa=strcat(int2str(nazwy_plikow(i)),'_evt_loc_flt');
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',strcat(nazwa,'FILTROWANE.set'),'filepath','C:\\_a\\EEG\\ASR\\eeglab14_1_1b\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'extended',1,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(nazwa,'ICA.set'),'savenew',strcat(nazwa,'ICA.set'),'gui','off'); 
end;