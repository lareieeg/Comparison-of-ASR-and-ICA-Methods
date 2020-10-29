% wczytanie folderow
pathnameD='C:/Dokumenty/artykul/datasety artefakty';

filenamD=dir(pathnameD); %zawartosc datasety artefakty
filenameD=struct2cell(filenamD);  
filenamesD=filenameD(1,3:end)'; %bez . ..
lenD=length(filenamesD);

%dla kazdego katalogu
for j=1:lenD

pathname=strcat(pathnameD,'\',filenamesD{j});
results_dir=strcat('C:/Dokumenty/artykul/resultsAfterASR','\',filenamesD{j});
mkdir(results_dir);
% results_divided\katalog\

filenam=dir(pathname); 
filename=struct2cell(filenam);  
filenames=filename(1,3:end)'; %pominiecie . ..
len=length(filenames);

for i=1:1:len
  % fileNameMat=filenames{i}; % nazwy plików z rozsz. *.set
  % c = strfind(fileNameMat, '.mat'); 
   %fNameBezMat=strcat(fileNameMat(1:c-1));  % nazwa pliku bez rozszerzenia
   
   analiza(pathname,filenames{i},results_dir);
end

end
 

