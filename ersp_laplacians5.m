function ersp_laplacians5(pathname, fName, fileNameSet, results_dir_full)

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',fileNameSet,'filepath',pathname);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

%du¿y laplacian (wczeœniej: ma³y)
%C3-0.25 (F3+Cz+P3+T7) %(FC3+C1+CP3+C5)
%C4-0.25 (F4+Cz+P4+T8) %(FC4+C2+CP4+C6)
[chan_nr]=findChannelsNo({'C3','F3','Cz','P3','T7','C4','F4','P4','T8'},EEG);
c3=chan_nr(1);
f3=chan_nr(2);
cz=chan_nr(3);
p3=chan_nr(4);
t7=chan_nr(5);

c4=chan_nr(6);
f4=chan_nr(7);
p4=chan_nr(8);
t8=chan_nr(9);

% legenda=["FP1";"FP2";"F7";"F3";"FZ";"F4";"F8";"FC5";"FC1";"FC2";"FC6";"T7";"C3";"Cz";"C4";"T8";"TP9";"CP5";"CP1";"CP2";"CP6";"TP10";"P7";"P3";"PZ";"P4";"P8";"PO9";"O1";"Oz";"O2";"PO10";"AF7";"AF3";"AF4";"AF8";"F5";"F1";"F2";"F6";"FT9";"FT7";"FC3";"FC4";"FT8";"FT10";"C5";"C1";"C2";"C6";"TP7";"CP3";"CPZ";"CP4";"TP8";"P5";"P1";"P2";"P6";"PO7";"PO3";"POz";"PO4";"PO8";"FCz"];
% c3=find(legenda=="C3");
% f3=find(legenda=="F3");
% cz=find(legenda=="Cz");
% p3=find(legenda=="P3");
% t7=find(legenda=="T7");
% 
% c4=find(legenda=="C4");
% f4=find(legenda=="F4");
% p4=find(legenda=="P4");
% t8=find(legenda=="T8");

laplasianC3=[];
laplasianC4=[];


   if ~isempty(c3) && ~isempty(f3)&& ~isempty(cz)&&~isempty(p3)&&~isempty(t7)...
      ~isempty(c4) && ~isempty(f4)&& ~isempty(cz)&&~isempty(p4)&&~isempty(t8)
  
   s=EEG.data;
   laplasianC3=s(c3,:)-0.25*(s(f3,:)+s(cz,:)+s(p3,:)+s(t7,:));
   laplasianC4=s(c4,:)-0.25*(s(f4,:)+s(cz,:)+s(p4,:)+s(t8,:));
 
   else
       disp('Brak odpowiednich elektrod');
       return;
   end
   
 EEG2=EEG;
 EEG2.data(c3,:)=laplasianC3;
 EEG2.data(c4,:)=laplasianC4;
 
 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG2, 1,'setname',strcat(fName(1:end-2),'_laplacian_5'),'savenew',strcat(results_dir_full,'\',fName(1:end-2),'_laplacian_5.set'),'gui','off'); 
