function [m,el]=  prepare_icc(pathname, fName, fileNameSet)
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
m=EEG.data(:,26:175,:);
el=[];
for i=1:1:size(EEG.chanlocs,2)
   el=[el; convertCharsToStrings(EEG.chanlocs(i).labels)]; 
end


