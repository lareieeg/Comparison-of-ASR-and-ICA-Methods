function analiza(pathname, fName, saveDirPath)
%pociecie sygnalu dla danego datasetu datasety artefakty/katalog/plik.m

%ladowanie do pamieci
load(strcat(pathname,'\',fName));

fName='eyeblink_dataset_wet_5';
pathname='C:/Dokumenty/';
%adjust EEG
EEG=adjustFormat(EEG,fName,pathname);

%filtrowanie
x=EEG;
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG=x;
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat('p1','xxx'),'savenew',strcat('C:/Dokumenty','/','pxxx.set'),'gui','off');

EEG = pop_eegfiltnew(EEG,1,40,[], 0, [], 0);

%usuniecie bad channels
x=EEG;
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG=x;
EEG = clean_rawdata(EEG, -1, -1, -1, 4, -1, -1); 

%pociecie sygnalu na odcinki 1s z oknem 0.5s
data=pociecieSygnalu(EEG.data');

%zapisanie pliku pocietego
save(strcat(saveDirPath,'\',fName),'data');

end