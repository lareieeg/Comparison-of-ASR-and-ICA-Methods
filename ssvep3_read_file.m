% wczytac folder
% wczytac nazwy plikow z folderu
% wczytac nazwê pliku z signal

close all;
clear all;

pathname='data_in_groups';
ica_asr_folds={'ASR','ICA'};
results_dir='results'; 

channelsList={'O1';'O2'};
    data_EEG='datasets';

for j=1:length(ica_asr_folds)
    
    results_dir_full=strcat(results_dir,'\',ica_asr_folds{j},'\','ssvep3');
    status = mkdir(results_dir_full);
    data_EEG_dir=strcat(results_dir_full,'\',data_EEG);
    status = mkdir(data_EEG_dir);
    result_file_no_extension_freq='All_SSVEP_Freq'; % czêstotliwoœæ SSVEP w 16 Hz - uœrednione dla epok (nag³ówek: plik, el.1, el.2, ...); w wierszach: kolejne osoby 
    result_file_no_extension_EyesClosed_freq='All_EyesClosed_Freq'; % czêstotliwoœæ EyesClosed w 16 Hz (nag³ówek: plik, el.1, el.2, ...); w wierszach: kolejne osoby
    result_file_no_extension_av_ratio='All_SSVEP_AvRatio'; % stosunek czêstotliwoœci SSVEP (uœrednionej) do Eyes Closed w 16 Hz  (nag³ówek: plik, el.1, el.2, ...)
    saveDirPath_no_extension_freq=strcat(results_dir_full,'\',result_file_no_extension_freq);
    saveDirPath_no_extension_EyesClosed_freq=strcat(results_dir_full,'\',result_file_no_extension_EyesClosed_freq);
    saveDirPath_no_extension_av_ratio=strcat(results_dir_full,'\',result_file_no_extension_av_ratio);
    saveDirPath_csv_freq=strcat(saveDirPath_no_extension_freq,'.csv');
    saveDirPath_csv_EyesClosed_freq=strcat(saveDirPath_no_extension_EyesClosed_freq,'.csv');
    saveDirPath_csv_av_ratio=strcat(saveDirPath_no_extension_av_ratio,'.csv');
    
    % plik 1
    f=fopen(saveDirPath_csv_freq,'w');
    %naglowek
fprintf(f,'%s', 'plik');
for n=1:length(channelsList)
    fprintf(f,'\t%s',channelsList{n});
end
fprintf(f,'\r\n');
    
    fclose(f);
            
    % plik 2
    ff=fopen(saveDirPath_csv_EyesClosed_freq,'w');
    %naglowek
fprintf(ff,'%s', 'plik');
for n=1:length(channelsList)
    fprintf(ff,'\t%s',channelsList{n});
end
fprintf(ff,'\r\n');
    
    fclose(ff);    
    
    % plik 3
    fff=fopen(saveDirPath_csv_av_ratio,'w');
    %naglowek
fprintf(fff,'%s', 'plik');
for n=1:length(channelsList)
    fprintf(fff,'\t%s',channelsList{n});
end
fprintf(fff,'\r\n');
    
    fclose(fff);
    
    pathname_dir=strcat(pathname,'\',ica_asr_folds{j},'\','3');
    pathname_dir_2=strcat(pathname,'\',ica_asr_folds{j},'\','2');
% nazewnictwo - przyk³ad: 001 malgorzata_ASR_after_BadChanRem_1.set
% wczytanie: pliku z danymi z rozszerzeniem set, bez konkretnej nazwy

    % odczyt z kat.1
    filenam=dir(pathname_dir); 
    filename=struct2cell(filenam);  
    filenames=filename(1,3:end)';
    len=length(filenames);
    filenames_set=cell(0);
    ti=1;
    ci=1;
    for i=1:len
        f=filenames{i};
        c = strfind(f, '.set');  
        if ~isempty(c) 
%         ff = strfind(f, 'AQT');
%         if ~isempty(ff) 
            filenames_set{ci}=f;
            ci=ci+1;
%        end
        end
    end
    for i=1:ci-1
        fileNameSet=filenames_set{i}; % nazwy plików z rozsz. *.set
        c = strfind(fileNameSet, '.set'); 
        fName=fileNameSet(1:c-1);  % nazwa pliku bez rozszerzenia
        fName2=strcat([fName(1:length(fName)-1),'2'],'.set'); % nazwa pliku z rozszerzeniem z 2
        fName=strcat(fName,'.set'); % nazwa pliku z rozszerzeniem 

    %wczytanie plików 
        [AlphaEyesClosed(i,:) EpochsSSVEP(i,:) AvSSVEPRatio(i,:)] = ssvep3(pathname_dir, pathname_dir_2, fName, fName2, saveDirPath_csv_freq, saveDirPath_csv_EyesClosed_freq, saveDirPath_csv_av_ratio, channelsList, data_EEG_dir); 
    end  
 
    SSVEP_All{j,1}=AlphaEyesClosed;
    SSVEP_All{j,2}=EpochsSSVEP;
    SSVEP_All{j,3}=AvSSVEPRatio;
    
    SSVEP_All{j,4}=ica_asr_folds{j};
end

save('SSVEP_3.mat', 'SSVEP_All');
