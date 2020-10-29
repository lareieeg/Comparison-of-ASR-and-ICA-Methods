% wczytanie folderow
load_components
pathnameD='data';

filenamD=dir(pathnameD); 
filenameD=struct2cell(filenamD);  
filenamesD=filenameD(1,3:end)'; %bez . ..
lenD=length(filenamesD);

%dla kazdego katalogu
for j=1:lenD
pathname=strcat(pathnameD,'\',filenamesD{j});
filenam=dir(pathname); 
filename=struct2cell(filenam);  
filenames=filename(1,3:end)'; %pominiecie . ..
len=length(filenames);
filenames_set=cell(0);
ti=1;
ci=1;
for i=1:len %wybranie plikow ktore sa z koncowka _ICA_after_BadChanRem
    
    f=filenames{i};
    c = strfind(f, '_ICA_after_BadChanRem.set'); 
    if ~isempty(c)
            filenames_set{ci}=f;
            ci=ci+1;

    end
end
for i=1:ci-1 %dla kazdego z wybranych plikow 
    fileNameSet=filenames_set{i}; % nazwy plików z rozsz. *.set
    c = strfind(fileNameSet, '.set'); 
    fName=strcat(fileNameSet(1:c-1));  % nazwa pliku bez rozszerzenia
    id=filenamesD{j};
   ica_components_remove(pathname, fName, fileNameSet,id,components,patients); 
end  

end
 

