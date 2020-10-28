function [meanAlpha] = resting1_2 (pathname_dir_1, pathname_dir_2, fName1, fName2, saveDirPath_csv, channelsList)


% oblicza Power Spectral Density dla triali oraz dla sredniej
%czestotliwosc=16;%Hz


%otwarcie eeglab
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;


 	freq=250;
    winLength=5; % 5 sec
    winSize=freq*winLength;
    overl=winSize/2;
    lowerFreq=8;
    higherFreq=13;

    %epoki - brak epok 
    %analiza spektrum
    
 %³adowanie pliku eyes open
EEG1 = pop_loadset('filename',fName1,'filepath',pathname_dir_1);
% sprawdziæ które wiersze odpowiadaj¹ szukanym elektrodom
[channs1]= findChannelsNo(channelsList,EEG1);

 %   figure;  [specs_noWindow, freqs_noWindow] = pop_spectopo(EEG, 1, [0 nPoints], 'EEG' , 'plotchans',channs); % 'freqrange',[8 13]
    figure;  [specs1, freqs1] = spectopo(EEG1.data(channs1,:),0,EEG1.srate,'winsize',winSize,'overlap',overl, 'nfft',EEG1.srate);  %'freqrange',[8 13]
    meanAlpha1 = mean(specs1(:,find(freqs1 == lowerFreq) : find(freqs1 == higherFreq)),2);
  %  sumAlpha(pl,:) = sum(specs(:,find(freqs == lowerFreq) : find(freqs == higherFreq)),2);
    
   %³adowanie pliku eyes closed
EEG2 = pop_loadset('filename',fName2,'filepath',pathname_dir_2);
[channs2]= findChannelsNo(channelsList,EEG2);
 %   figure;  [specs_noWindow, freqs_noWindow] = pop_spectopo(EEG, 1, [0 nPoints], 'EEG' , 'plotchans',channs); % 'freqrange',[8 13]
    figure;  [specs2, freqs2] = spectopo(EEG2.data(channs2,:),0,EEG2.srate,'winsize',winSize,'overlap',overl, 'nfft',EEG2.srate);  %'freqrange',[8 13]
    meanAlpha2 = mean(specs2(:,find(freqs2 == lowerFreq) : find(freqs2 == higherFreq)),2);
  
  meanAlpha=meanAlpha1./meanAlpha2;
    f=fopen(saveDirPath_csv,'a');
    fprintf(f,'%s',fName1);
    for n=1:length(channelsList)
        fprintf(f,'\t%f',meanAlpha(n));
    end
fprintf(f,'\r\n');        

fclose(f);

