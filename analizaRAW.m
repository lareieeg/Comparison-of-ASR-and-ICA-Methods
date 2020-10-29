% EEGLAB history file generated on the 02-Feb-2018
% ------------------------------------------------
epoki=[];
nazwy_plikow=[1102 1103 1106 1107 1109 1110 1111 1119 1205 1208 ];
for i=1:1:10
%ladowanie pliku
nazwa=strcat(int2str(nazwy_plikow(i)),'_evt_loc_flt');
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',strcat(nazwa,'.set'),'filepath','C:\\_a\\EEG\\ASR\\daneDarek1\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
napis=EEG.setname;
%filtrowanie
EEG = pop_eegfiltnew(EEG, 0.5,40,3300,0,[],1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(nazwa,'FILTROWANE.set'),'savenew',strcat(nazwa,'FILTROWANE.set'),'gui','off'); 
EEG = eeg_checkset( EEG );
end;
