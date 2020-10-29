% EEGLAB history file generated on the 02-Feb-2018
% ------------------------------------------------

epoki=[];
%nazwy_plikow=[1102 1103 1106 1107 1109 1110 1111 1119 1205 1208 ];
nazwy_plikow=[1102];
for i=1:1:1
nazwa=strcat(int2str(nazwy_plikow(i)),'_evt_loc_flt');
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',strcat(nazwa,'FILTROWANE.set'),'filepath','C:\\_a\\EEG\\ASR\\eeglab14_1_1b\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = clean_rawdata(EEG, 5, [-1], 0.8, 4, 5, 0.5);
EEG = eeg_checkset( EEG );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',strcat(nazwa,'ASR.set'),'gui','off'); 
end;