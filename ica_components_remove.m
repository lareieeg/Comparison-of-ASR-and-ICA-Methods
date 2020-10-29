function ica_components_remove(pathname, fName, fileNameSet,id,components,patients)
%wyszukanie numeru w tablicy po patient
index=find(patients==id)
%pobranie komponentow do usuniecia
comp=components{index};
%usuwanie komponentow - nadpisanie istniejacego pliku
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, comp, 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',fName,'savenew',strcat(pathname,'\',fileNameSet),'gui','off'); 