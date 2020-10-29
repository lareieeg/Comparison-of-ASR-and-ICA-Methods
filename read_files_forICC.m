function read_files_forICC(file)
tr=[];
tLB=[];
tUB=[];
tF=[];
tdf1=[];
tdf2=[];
tp=[];
pathname='matrix_forICC';
data=load(strcat(pathname,'\',file));
%uniezaleznienie zmiennych od wczytywania
data=struct2cell(data);
data = data{1};
for i=1:1:size(data, 1)
   [r, LB, UB, F, df1, df2, p]= ICC(data{i},'1-1',0.05);
   tr=[tr ;r];
   tLB=[tLB;LB];
   tUB=[tUB;UB];
   tF=[tF;F];
   tdf1=[tdf1;df1];
   tdf2=[tdf2;df2];
   tp=[tp;p];
end;
%zapisywanie
in=strfind(file,'.mat');
results_dir=strcat('files_afterICC','\',file(1:1:in-1));
mkdir(results_dir);
save(strcat(results_dir,'\','tr.mat'),'tr'); 
save(strcat(results_dir,'\','tUB.mat'),'tUB'); 
save(strcat(results_dir,'\','tLB.mat'),'tLB');
save(strcat(results_dir,'\','tF.mat'),'tF'); 
save(strcat(results_dir,'\','tdf1.mat'),'tdf1'); 
save(strcat(results_dir,'\','tdf2.mat'),'tdf2'); 
save(strcat(results_dir,'\','tp.mat'),'tp'); 
end
%wywolanie
%read_files_forICC('asr_X.mat');
%read_files_forICC('asr_O.mat');
%read_files_forICC('ica_X.mat');
%read_files_forICC('ica_O.mat');