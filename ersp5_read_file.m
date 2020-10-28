% wczytac folder
% wczytac nazwy plikow z folderu
% wczytac nazwê pliku z signal

% study - laplacians

close all;
%clear all;

pathname='data_in_groups';
ica_asr_folds={'ASR','ICA'};
l_r_folds={'L','R','Rest'};
results_dir='results-test'; % tylko na potrzeby ponownych testów, orygnialnie - folder 'results' 
%signal_ind_start=26;

channelsList={'C3';'C4'};


for j=1:length(ica_asr_folds)
    
    results_dir_full=strcat(results_dir,'\',ica_asr_folds{j},'\','ersp5');
    status = mkdir(results_dir_full);
    result_file_no_extension_ersp='All_ERPs';  
    saveDirPath_no_extension_ersp=strcat(results_dir_full,'\',result_file_no_extension_ersp);
    saveDirPath_csv_ersp=strcat(saveDirPath_no_extension_ersp,'.csv');
    result_file_no_extension_ersp_Pfursch='All_ERPs_Pfursch';  
    saveDirPath_no_extension_ersp_Pfursch=strcat(results_dir_full,'\',result_file_no_extension_ersp_Pfursch);
    saveDirPath_csv_ersp_Pfursch=strcat(saveDirPath_no_extension_ersp_Pfursch,'.csv');
    
    % plik 1
    f=fopen(saveDirPath_csv_ersp,'w');
    %naglowek
fprintf(f,'%s\t%s\t%s', 'plik', 'ica/asr', 'L/R/Rest');
for n=1:length(channelsList)
    fprintf(f,'\t%s',strcat(channelsList{n},'-alpha'));
    fprintf(f,'\t%s',strcat(channelsList{n},'-beta'));
end
fprintf(f,'\r\n');
     
    fclose(f);
           
        
    % plik 2
    ff=fopen(saveDirPath_csv_ersp_Pfursch,'w');
    %naglowek
fprintf(ff,'%s\t%s\t%s', 'plik', 'ica/asr', 'L/R/Rest');
for n=1:length(channelsList)
    fprintf(ff,'\t%s',strcat(channelsList{n},'-alpha'));
    fprintf(ff,'\t%s',strcat(channelsList{n},'-beta'));
end
fprintf(ff,'\r\n');
     
    fclose(ff);

    
    pathname_dir=strcat(pathname,'\',ica_asr_folds{j},'\','ERSP-Study');
% nazewnictwo - przyk³ad: ERSP_Data_laplacian_ICA_L.study
% wczytanie: pliku z danymi z rozszerzeniem study, bez konkretnej nazwy

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
        c = strfind(f, '.study');  
        if ~isempty(c) 
%         ff = strfind(f, 'AQT');
%         if ~isempty(ff) 
            filenames_set{ci}=f;
            ci=ci+1;
%        end
        end
    end
    
    fileName_L='';
    fileName_R='';
    fileName_Rest='';
    
    for i=1:ci-1
        fileNameSet=filenames_set{i}; % nazwy plików z rozsz. *.study
        c_L = strfind(fileNameSet, '_laplacian_L.study'); 
        c_R = strfind(fileNameSet, '_laplacian_R.study'); 
        c_Rest = strfind(fileNameSet, '_laplacian_Rest.study');
        if (~isempty(c_L) && isempty(fileName_L))
            fileName_L=fileNameSet;
            file_l_flag=1;
        elseif (~isempty(c_R) && isempty(fileName_R))
            fileName_R=fileNameSet;
            file_r_flag=1;
        elseif (~isempty(c_Rest) && isempty(fileName_Rest))
            fileName_Rest=fileNameSet;
            file_rest_flag=1;
        end
    end

        %%%%
        ersp=[];
        ersp_Pfursch=[];
        for i=1:length(l_r_folds)
            stim=l_r_folds{i};
            if strcmp(stim,'L')
    %wczytanie plików  
                [ersp{i} ersp_Pfursch{i}]=ersp5(pathname_dir,fileName_L, saveDirPath_csv_ersp, saveDirPath_csv_ersp_Pfursch, results_dir_full, channelsList);
                close all;
            elseif strcmp(stim,'R')
    %wczytanie plików  
                [ersp{i} ersp_Pfursch{i}]=ersp5(pathname_dir,fileName_R, saveDirPath_csv_ersp, saveDirPath_csv_ersp_Pfursch, results_dir_full, channelsList);
                 close all;
            elseif strcmp(stim,'Rest')
                [ersp{i} ersp_Pfursch{i}]=ersp5(pathname_dir,fileName_Rest, saveDirPath_csv_ersp, saveDirPath_csv_ersp_Pfursch, results_dir_full, channelsList);
                close all;
            end
        end
 
        
    %%% 
    ERSP_All{j,1}=ersp;
    ERSP_All{j,2}=ersp_Pfursch;
    ERSP_All{j,3}={'L','R','Rest'};
    ERSP_All{j,4}=ica_asr_folds{j};
end

save('ERSP_5.mat', 'ERSP_All');
