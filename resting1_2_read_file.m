% wczytac folder
% wczytac nazwy plikow z folderu
% wczytac nazwê pliku z signal

close all;
clear all;

pathname='data_in_groups';
ica_asr_folds={'ASR','ICA'};
results_dir='results'; 

channelsList={'P3'; 'PZ'; 'P4'; 'POz'; 'O1'; 'O2'};

for j=1:length(ica_asr_folds)
    
    results_dir_full=strcat(results_dir,'\',ica_asr_folds{j},'\','resting1_2');
    status = mkdir(results_dir_full);
    result_file_no_extension='All_EyesOpenClosed';
    saveDirPath_no_extension=strcat(results_dir_full,'\',result_file_no_extension);
    saveDirPath_csv=strcat(saveDirPath_no_extension,'.csv');
    f=fopen(saveDirPath_csv,'w');
    %naglowek
fprintf(f,'%s', 'plik');
for n=1:length(channelsList)
    fprintf(f,'\t%s',channelsList{n});
end
fprintf(f,'\r\n');
    
    fclose(f);
        
    pathname_dir_1=strcat(pathname,'\',ica_asr_folds{j},'\','1');
    pathname_dir_2=strcat(pathname,'\',ica_asr_folds{j},'\','2');
% nazewnictwo - przyk³ad: 001 malgorzata_ASR_after_BadChanRem_1.set
% wczytanie: pliku z danymi z rozszerzeniem set, bez konkretnej nazwy

    % odczyt tylko z kat.1
    filenam=dir(pathname_dir_1); 
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
        fName1=strcat(fName,'.set'); % nazwa pliku z rozszerzeniem z 1
        fName2=strcat([fName(1:length(fName)-1),'2'],'.set'); % nazwa pliku z rozszerzeniem z 2

       


    %wczytanie plików 
        meanAlpha(i,:) = resting1_2(pathname_dir_1, pathname_dir_2, fName1, fName2, saveDirPath_csv, channelsList); 
    end  
 

    meanAlphaAll{j,1}=meanAlpha;
    meanAlphaAll{j,2}=ica_asr_folds{j};

end

save('meanAlphaAll_1_2.mat', 'meanAlphaAll');
