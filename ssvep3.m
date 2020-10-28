function [AlphaEyesClosed, EpochsSSVEP, AvSSVEPRatio] = ssvep3 (pathname_dir, pathname_dir_2, fName, fName2, saveDirPath_csv_freq, saveDirPath_EyesClosed_freq, saveDirPath_csv_av_ratio, channelsList,data_EEG_dir)

% oblicza Power Spectral Density dla triali oraz dla sredniej
czestotliwosc=16;%Hz
 	freq=250;
    % potrzebne w przypadku overlap
   % nTimeStart=round(8505/250); %pomijamy 3 pierwsze bodŸce
    nTime=7996;
    nPoints=1975;
    % winLength=8; % 8 sec
    winSize=nPoints; %freq*winLength;
    overl=winSize/2;
 
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
 
 %³adowanie pliku ssvep
EEG = pop_loadset('filename',fName,'filepath',pathname_dir);
% sprawdziæ które wiersze odpowiadaj¹ szukanym elektrodom
[channs]= findChannelsNo(channelsList,EEG);

    f=fopen(saveDirPath_csv_freq,'a');
    fprintf(f,'%s',fName);
    
    ff=fopen(saveDirPath_EyesClosed_freq,'a');
    fprintf(ff,'%s',fName);
    
    fff=fopen(saveDirPath_csv_av_ratio,'a');
    fprintf(fff,'%s',fName);
    
    %epoki SSVEP wg znacznika nr 6, od poczatku znacznika przez 8 sekund
    EEG = pop_epoch(EEG, {'6'}, [0 8]);  
EEG = pop_selectevent( EEG, 'epoch',[4:18] ,'deleteevents','off','deleteepochs','on','invertepochs','off'); %usun¹æ 3 pierwsze epoki
EEG.setname=[fName,'removedepochs'];

    %analiza spektrum 
    [specs, freqs] = pop_spectopo(EEG, 1, [0 nTime], 'EEG' , 'freqrange',[2 25],'plotchans',channs);
    czestotliwoscID = find(freqs==czestotliwosc);
    EpochsSSVEP=specs(:,czestotliwoscID); % po 1 wyniku na kana³
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',strcat(fName(1:end-4),'_epoched'),'savenew',strcat(data_EEG_dir,'\',fName(1:end-4),'_epoched.set'),'gui','off'); 

%     EpochsSSVEP=EpochsSSVEP(channs,:);
%     EpochsSSVEP_epochs_mean=mean(EpochsSSVEP);
    
       %³adowanie pliku eyes closed
EEG2 = pop_loadset('filename',fName2,'filepath',pathname_dir_2);
nPoints=EEG2.pnts;
[channs2]= findChannelsNo(channelsList,EEG2);
figure;  [specs2, freqs2] = spectopo(EEG2.data(channs2,:),0,EEG2.srate,'winsize',winSize, 'nfft',EEG2.srate);  %'freqrange',[8 13] % wersja z overlap
% figure;  [specs2, freqs2] = spectopo(EEG2.data(channs2,:),0,EEG2.srate, 'nfft',EEG2.srate);  %'freqrange',[8 13] % wersja z overlap
%figure;  [specs2_noWindow, freqs2_noWindow] = pop_spectopo(EEG, 1, [0 nPoints], 'EEG' , 'plotchans',channs2); % 'freqrange',[8 13]
  [ALLEEG EEG2 CURRENTSET] = pop_newset(ALLEEG, EEG2, 1,'setname',strcat(fName2(1:end-4),'_eyesClosed'),'savenew',strcat(data_EEG_dir,'\',fName2(1:end-4),'_eyesClosed.set'),'gui','off'); 
    czestotliwoscID = find(freqs2==czestotliwosc);
    AlphaEyesClosed=specs2(:,czestotliwoscID);
    
    AvSSVEPRatio=EpochsSSVEP./AlphaEyesClosed;
    
    % zapis do 3 plików
    
      % plik 1 % czêstotliwoœci dla kana³ów (po epokach) 

    for n=1:length(channelsList)
        fprintf(f,'\t%f',EpochsSSVEP(n));
    end
    fprintf(f,'\r\n');

    fclose(f);
            
    % plik 2 % czêstotliwoœæ Eyes closed
  %  ff=fopen(saveDirPath_EyesClosed_freq,'w');
for n=1:length(channelsList)
    fprintf(ff,'\t%f',AlphaEyesClosed(n));
end
fprintf(ff,'\r\n');
    
    fclose(ff);    
    
    % plik 3 % stosunek SSVEP/EC - SNR
 %   fff=fopen(saveDirPath_csv_av_ratio,'w');
    %naglowek
fprintf(fff,'%s', 'plik');
for n=1:length(channelsList)
    fprintf(fff,'\t%s',AvSSVEPRatio(n));
    
end
fprintf(fff,'\r\n');
    
    fclose(fff);
    