% EEGLAB history file generated on the 02-Feb-2018
% ------------------------------------------------
epoki=[];
nazwy_plikow=[1102 1103 1106 1107 1109 1110 1111 1119 1205 1208 ];
for i=1:1:10
%ladowanie pliku
nazwa=strcat(int2str(nazwy_plikow(i)),'_evt_loc_flt');
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',strcat(nazwa,'ICAusuniete.set'),'filepath','C:\\_a\\EEG\\ASR\\DaneEEG\\Analiza\\ICAusuniete\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
napis=EEG.setname;
%epokowanie
EEG = pop_epoch( EEG, {  'left'  'relx'  'rigt'  }, [0  3], 'newname', strcat(nazwa,'EPOKIICAusuniete.set'), 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',strcat(nazwa,'EPOKIICAusuniete.set'),'gui','off'); 
epoki=[epoki EEG.trials];
end;
