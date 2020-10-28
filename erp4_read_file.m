% wczytac folder
% wczytac nazwy plikow z folderu
% wczytac nazwê pliku z signal

close all;
clear all;

pathname='data_in_groups';
ica_asr_folds={'ASR','ICA'};
x_o_folds={'X','O'};
results_dir='results-test'; % tylko na potrzeby ponownych testów, orygnialnie - folder 'results'
signal_ind_start=26;

channelsListWin={'PZ'};
channelsList={'FZ';'FCz';'C3';'Cz';'C4';'CPZ';'P7';'P3';'PZ';'P4';'P8';'PO7';'PO3';'POz';'PO4';'PO8';'O1';'Oz';'O2'};


for j=1:length(ica_asr_folds)
    
    results_dir_full=strcat(results_dir,'\',ica_asr_folds{j},'\','erp4');
    status = mkdir(results_dir_full);
    result_file_no_extension_erp_peaks='All_ERP_peaks'; 
    result_file_no_extension_erp_means='All_ERP_means'; 
    result_file_no_extension_erp_variance='All_ERP_variance'; 
    result_file_no_extension_erp_snr='All_ERP_snr'; 
    saveDirPath_no_extension_erp_peaks=strcat(results_dir_full,'\',result_file_no_extension_erp_peaks);
    saveDirPath_no_extension_erp_means=strcat(results_dir_full,'\',result_file_no_extension_erp_means);
    saveDirPath_no_extension_erp_variance=strcat(results_dir_full,'\',result_file_no_extension_erp_variance);
    saveDirPath_no_extension_erp_snr=strcat(results_dir_full,'\',result_file_no_extension_erp_snr);
    saveDirPath_csv_erp_peaks=strcat(saveDirPath_no_extension_erp_peaks,'.csv');
    saveDirPath_csv_erp_means=strcat(saveDirPath_no_extension_erp_means,'.csv');
    saveDirPath_csv_erp_variance=strcat(saveDirPath_no_extension_erp_variance,'.csv');
    saveDirPath_csv_erp_snr=strcat(saveDirPath_no_extension_erp_snr,'.csv');
    
    % plik 1
    f=fopen(saveDirPath_csv_erp_peaks,'w');
    %naglowek
fprintf(f,'%s\t%s\t%s', 'plik', 'ica/asr', 'X/O');
for n=1:length(channelsList)
    fprintf(f,'\t%s',channelsList{n});
end
fprintf(f,'\r\n');
     
    fclose(f);
           
    % plik 2
    ff=fopen(saveDirPath_csv_erp_means,'w');
    %naglowek
fprintf(ff,'%s\t%s\t%s', 'plik', 'ica/asr', 'X/O');
for n=1:length(channelsList)
    fprintf(ff,'\t%s',channelsList{n});
end
fprintf(ff,'\r\n');
    
    fclose(ff);    
    
    % plik 3
    fff=fopen(saveDirPath_csv_erp_variance,'w');
    %naglowek
fprintf(fff,'%s\t%s\t%s', 'plik', 'ica/asr', 'X/O');
for n=1:length(channelsList)
    fprintf(fff,'\t%s',channelsList{n});
end
fprintf(fff,'\r\n');
    
    fclose(fff);
    
        
    % plik 4
    ffff=fopen(saveDirPath_csv_erp_snr,'w');
    %naglowek
fprintf(ffff,'%s\t%s\t%s', 'plik', 'ica/asr', 'X/O');
for n=1:length(channelsList)
    fprintf(ffff,'\t%s',channelsList{n});
end
fprintf(ffff,'\r\n');
    
    fclose(ffff);
    
    pathname_dir=strcat(pathname,'\',ica_asr_folds{j},'\','ERP-Study');
% nazewnictwo - przyk³ad: ERPDataAfterBaseline_ASR_O.study
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
    
    fileName_X='';
    fileName_O='';
    
    for i=1:ci-1
        fileNameSet=filenames_set{i}; % nazwy plików z rozsz. *.study
        c_X = strfind(fileNameSet, '_X.study'); 
        c_O = strfind(fileNameSet, '_O.study'); 
        if (~isempty(c_X) && isempty(fileName_X))
            fileName_X=fileNameSet;
            file_x_flag=1;
        elseif (~isempty(c_O) && isempty(fileName_O))
            fileName_O=fileNameSet;
            file_o_flag=1;
        end
    end
    
        [P300Window P300locsPkt]=findP300Window(pathname_dir,fileName_X,fileName_O, channelsListWin,signal_ind_start); %punkty
         
        p300WindowRange=[P300locsPkt-ceil(P300Window); P300locsPkt+ceil(P300Window)]; % liczone od -100, od baseline
     p300WindowRange_ms=p300WindowRange*4 % zakres w ms - pogl¹dowo
        %%%%
        for i=1:length(x_o_folds)
            stim=x_o_folds{i};
            if strcmp(stim,'X')
    %wczytanie plików  
                [erp_peaks{i}, erp_means{i}, erp_variance{i}, erp_snr{i}, erp_locs{i}]=erp4(pathname_dir,fileName_X, saveDirPath_csv_erp_peaks, saveDirPath_csv_erp_means, saveDirPath_csv_erp_variance, saveDirPath_csv_erp_snr, results_dir_full, channelsList, p300WindowRange, signal_ind_start);
                close all;
            else
                [erp_peaks{i}, erp_means{i}, erp_variance{i}, erp_snr{i}, erp_locs{i}]=erp4(pathname_dir,fileName_O, saveDirPath_csv_erp_peaks, saveDirPath_csv_erp_means, saveDirPath_csv_erp_variance, saveDirPath_csv_erp_snr, results_dir_full, channelsList, p300WindowRange, signal_ind_start);
                close all;
            end
        end
 
        
    %%% 
    ERP_All{j,1}=erp_peaks;
    ERP_All{j,2}=erp_means;
    ERP_All{j,3}=erp_variance;
    ERP_All{j,4}=erp_snr;
    ERP_All{j,5}=erp_locs;
    ERP_All{j,4}={'x','o'};
    ERP_All{j,5}=ica_asr_folds{j};
end

save('ERP_4.mat', 'ERP_All');
