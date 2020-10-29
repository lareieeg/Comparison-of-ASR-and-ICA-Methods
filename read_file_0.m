% wczytanie folderow
pathnameD='data';

filenamD=dir(pathnameD); 
filenameD=struct2cell(filenamD);  
filenamesD=filenameD(1,3:end)'; %bez . ..
lenD=length(filenamesD);

%dla kazdego katalogu
for j=1:lenD

pathname=strcat(pathnameD,'\',filenamesD{j});
results_dir=strcat('results_divided','\',filenamesD{j});
mkdir(results_dir);
% results_divided\katalog\

filenam=dir(pathname); 
filename=struct2cell(filenam);  
filenames=filename(1,3:end)'; %pominiecie . ..
len=length(filenames);
filenames_set=cell(0);
ti=1;
ci=1;
for i=1:len %wybranie plikow ktore sa z koncowka after_BadChanRem
    
    f=filenames{i};
    c = strfind(f, 'after_BadChanRem.set'); 
    if ~isempty(c)
            filenames_set{ci}=f;
            ci=ci+1;

    end
end
for i=1:ci-1 %dla kazdego z wybranych plikow ( po dwa pliki dla kazdego katalogu)
    fileNameSet=filenames_set{i}; % nazwy plików z rozsz. *.set
    c = strfind(fileNameSet, '.set'); 
    fName=strcat(fileNameSet(1:c-1));  % nazwa pliku bez rozszerzenia
    saveDirPath=strcat(results_dir,'\',fName);
    status = mkdir(saveDirPath);
% results_divided\katalog\katalog\pliki
 % pathname='data\martyna1\';
  %  fName='martyna_1_Filter_1_40';
  % fileNameSet='martyna_1_Filter_1_40.set';
   analysis_ASR_cpm_1 (pathname, fName, fileNameSet,saveDirPath); 
end  

end
 

