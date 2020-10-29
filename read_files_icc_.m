%macierze dla icc
asr_X=cell(65,1);%{};
asr_O=cell(65,1);
ica_X=cell(65,1);
ica_O=cell(65,1);
legenda=["FP1";"FP2";"F7";"F3";"FZ";"F4";"F8";"FC5";"FC1";"FC2";"FC6";"T7";"C3";"Cz";"C4";"T8";"TP9";"CP5";"CP1";"CP2";"CP6";"TP10";"P7";"P3";"PZ";"P4";"P8";"PO9";"O1";"Oz";"O2";"PO10";"AF7";"AF3";"AF4";"AF8";"F5";"F1";"F2";"F6";"FT9";"FT7";"FC3";"FC4";"FT8";"FT10";"C5";"C1";"C2";"C6";"TP7";"CP3";"CPZ";"CP4";"TP8";"P5";"P1";"P2";"P6";"PO7";"PO3";"POz";"PO4";"PO8";"FCz"];

% wczytanie folderow
pathnameD='results_withoutBaseline';

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
%results_dir=strcat('results_withoutBaseline','\',filenamesD{j},'\',filenamesK{k});
%mkdir(results_dir);
% results_withoutBaseline\katalog\

filenam=dir(pathname); 
filename=struct2cell(filenam);  
filenames=filename(1,3:end)'; %pominiecie . ..
len=length(filenames);
filenames_set=cell(0);
ti=1;
ci=1;

for i=1:len %wybranie plikow ktore sa z koncowka >set
   f=filenames{i};
    c = strfind(f, '.set'); 
    if ~isempty(c)
            filenames_set{ci}=f;
            ci=ci+1;

    end

end
for i=1:ci-1 %dla kazdego z wybranych plikow 
    fileNameSet=filenames_set{i}; % nazwy plików z rozsz. *.set
    c = strfind(fileNameSet, '.set'); 
    fName=strcat(fileNameSet(1:c-1));  % nazwa pliku bez rozszerzenia
  
    %epokowanie i usuniecie baseline
   [m,el]=prepare_icc(pathname, fName, fileNameSet); 
   
   %przydzial odpowiednich wierszy macierzy m do macierzy dla icc na
   %podstawie el
  for t=1:1:size(legenda)
   spr_el=find(el==legenda(t)); %sprawdznenie czy dana elektroda istnieje
   if ~isempty(spr_el)
    r=strfind(fName,"_X");
    if ~isempty(r) %plik X
      r=strfind(filenamesK{k},"_ASR");
       if ~isempty(r) %ASR 
           disp("x z ASR");
           asr_X{spr_el}=[asr_X{spr_el};(reshape(m(spr_el,:,:), [size(m(spr_el,:,:),2) size(m(spr_el,:,:),3)]))'];
       else %ICA
           disp("x z ica");
           ica_X{spr_el}=[ica_X{spr_el};(reshape(m(spr_el,:,:), [size(m(spr_el,:,:),2) size(m(spr_el,:,:),3)]))'];
       end
    else %plik O
       r=strfind(filenamesK{k},"_ASR");
       if ~isempty(r) %ASR  
           disp("o z asr");
           asr_O{spr_el}=[asr_O{spr_el};(reshape(m(spr_el,:,:), [size(m(spr_el,:,:),2) size(m(spr_el,:,:),3)]))'];
       else %ICA 
           disp("o z ica");
           ica_O{spr_el}=[ica_O{spr_el};(reshape(m(spr_el,:,:), [size(m(spr_el,:,:),2) size(m(spr_el,:,:),3)]))'];
       end
    end  %if r
    
   end % if spr_el
   
end %for t

end  %for i

end  %fir k
end %for j

%zapisywanie zmiennych
results_dir=strcat('matrix_forICC');
mkdir(results_dir);
save(strcat(results_dir,'\','asr_O.mat'),'asr_O'); %save(results_dir,'ica_O.mat','ica_O');
save(strcat(results_dir,'\','asr_X'),'asr_X');
save(strcat(results_dir,'\','ica_O'),'ica_O');
save(strcat(results_dir,'\','ica_X'),'ica_X');


