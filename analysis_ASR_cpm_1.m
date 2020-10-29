function analysis_ASR_cpm_1 (pathname, fName, fileNameSet, saveDirPath)
poczatki=[1 3 5 10 20]; %poczatki eventow
konce=[2 4 8 16 26]; % konce eventow
for j=1:1:5% kazdy z wczytanych plikow dzielony jest na 5 czesci
%otwarcie eeglab
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

%³adowanie pliku
display(fileNameSet);
display(pathname);
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

%konwersja z char na int
[EEG]= konwersja(EEG)

[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

% dzielenie pliku
[EEG] = flt_brake_rem_2 (EEG, saveDirPath, fName,int16(poczatki(j)),int16(konce(j))) 
[EEG]= konwersja(EEG) % konwersja aby zapisac int

nazwa=strcat('_',int2str(j)); % stowrzenie odpowiedniej nazwy
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(fName,nazwa),'savenew',strcat(saveDirPath,'\',fName,nazwa),'gui','off'); 
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
end;
