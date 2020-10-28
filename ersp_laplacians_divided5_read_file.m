% wczytac folder
% wczytac nazwy plikow z folderu
% wczytac nazwê pliku z signal

close all;
% clear all;

pathname='data_in_groups';
ica_asr_folds={'ASR','ICA'};
results_dir='results'; 

%channelsList={'O1';'O2'};
    data_EEG='datasets';
 
for j=1:length(ica_asr_folds)
    
    results_dir_full=strcat(pathname,'\',ica_asr_folds{j},'\','ERSP-Study','\','Laplacians-sets');
    status = mkdir(results_dir_full);

    
    pathname_dir=strcat(pathname,'\',ica_asr_folds{j},'\','ERSP-Study','\','Laplacians-no_epoched');
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
        fName2=strcat([fName(1:length(fName)-1),'5'],'.set'); % nazwa pliku z rozszerzeniem z 5
        fName=strcat(fName,'.set'); % nazwa pliku z rozszerzeniem 

    %wczytanie plików 
    
       % epoch_cut(pathname, fName, fileNameSet,saveDirPath); 
        epoch_cut(pathname_dir, fName(1:end-4), fName, results_dir_full); 
      %  ersp_laplacians5(pathname_dir, fName(1:end-4), fName, results_dir_full); 
 
    end  
 

end

