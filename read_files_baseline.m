% wczytanie folderow
pathnameD='results_divided';

filenamD=dir(pathnameD); 
filenameD=struct2cell(filenamD);  
filenamesD=filenameD(1,3:end)'; %bez . ..
lenD=length(filenamesD);

%dla kazdego katalogu
for j=1:lenD
pathname=strcat(pathnameD,'\',filenamesD{j});    
filenamK=dir(pathname); 
filenameK=struct2cell(filenamK);  
filenamesK=filenameK(1,3:end)'; %pominiecie . ..
lenK=length(filenamesK);

for k=1:lenK
pathname=strcat(pathnameD,'\',filenamesD{j},'\',filenamesK{k});
results_dir=strcat('results_withoutBaseline','\',filenamesD{j},'\',filenamesK{k});
mkdir(results_dir);
% results_withoutBaseline\katalog\

filenam=dir(pathname); 
filename=struct2cell(filenam);  
filenames=filename(1,3:end)'; %pominiecie . ..
len=length(filenames);
filenames_set=cell(0);
ti=1;
ci=1;

for i=1:len %wybranie plikow ktore sa z koncowka _4
    
    f=filenames{i};
    c = strfind(f, '_4.set'); 
    if ~isempty(c)
            filenames_set{ci}=f;
            ci=ci+1;

    end
end
for i=1:ci-1 %dla kazdego z wybranych plikow 
    fileNameSet=filenames_set{i}; % nazwy plików z rozsz. *.set
    c = strfind(fileNameSet, '.set'); 
    fName=strcat(fileNameSet(1:c-1));  % nazwa pliku bez rozszerzenia
    saveDirPath=strcat(results_dir);
    status = mkdir(saveDirPath);
  
    %epokowanie i usuniecie baseline
   rm_baseline(pathname, fName, fileNameSet,saveDirPath); 
end 

end

end

