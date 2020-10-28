 function [ersp_res, ersp_Pfursch_res]=ersp5(pathname_dir,fileName, saveDirPath_csv_ersp, saveDirPath_csv_ersp_Pfursch, results_dir_full, channelsList)

    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    [STUDY ALLEEG] = pop_loadstudy('filename', fileName, 'filepath', pathname_dir);
    CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
 %   [STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','ersp','on','erspparams',{'cycles' [3 0.8]  'nfreqs' 100 'ntimesout' 200});  % nfreqs=250?
    [STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','ersp','on','erspparams',{'cycles' [3 0.8] 'freqs' [8 30] 'baseline', [-1930 0]  'nfreqs' 100 'ntimesout' 200});  % 'baseline', [-19300 0]
STUDY_alpha = pop_erspparams(STUDY, 'freqrange',[8 13], 'timerange', [0 3990] );
[STUDY_alpha erspdata_alpha ersptimes_alpha erspfreqs_alpha pgroup_alpha pcond_alpha pinter_alpha] =  std_erspplot(STUDY_alpha,ALLEEG,'channels',{'C3' 'C4'});
STUDY_beta = pop_erspparams(STUDY, 'freqrange',[14 30], 'timerange', [0 3990]);
[ STUDY_beta erspdata_beta ersptimes_beta erspfreqs_beta pgroup_beta pcond_beta pinter_beta] =  std_erspplot(STUDY_beta,ALLEEG,'channels',{'C3' 'C4'});
[ STUDY_all erspdata_all ersptimes_all erspfreqs_all pgroup_all pcond_all pinter_all] =  std_erspplot(STUDY,ALLEEG,'channels',{'C3' 'C4'});

ersp_alpha=cell2mat(erspdata_alpha); %% change erspdata (cell) to double
ersp_Pfursch_alpha=(10.^(ersp_alpha/10)-1)*100;  % nie wiem, czy to jest potrzebne, na raize nie uwzglêdnione - Pfurscheller’s formula
 
ersp_beta=cell2mat(erspdata_beta); %% change erspdata (cell) to double
ersp_Pfursch_beta=(10.^(ersp_beta/10)-1)*100;   % nie wiem, czy to jest potrzebne, na raize nie uwzglêdnione - Pfurscheller’s formula
 

% S1ersp=ersp_alpha(:,:,:,1); %%extract data for S1
% S2ersp=ersp_beta(:,:,:,2); %% extract data for S2
% % 	>> idxfreqalpha=find(erspfreqs>=7 & erspfreqs <= 13); % alpha band between 7-13 Hz
% % 	>> idxfreqbeta=find(erspfreqs>=16 & erspfreqs <= 21); 
% % 	>> idxtime=find(ersptimes >= -2000 & ersptimes <=400); %% Analyze ersp between -2 seconds and +400ms
% % 	>> timex=ersptimes(ersptimes>= -2000 & ersptimes<=400); 
    
  
    [STUDY_alpha EEG] = pop_savestudy( STUDY_alpha, EEG, 'filename',strcat(fileName(1:end-6),'_afterERSP_alpha.study'),'filepath',results_dir_full);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
    [STUDY_beta EEG] = pop_savestudy( STUDY_beta, EEG, 'filename',strcat(fileName(1:end-6),'_afterERSP_beta.study'),'filepath',results_dir_full);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];


   
    
% wybraæ alfa i beta - uœredniæ do 1 wartoœci (oddzielnie dla alfa i dla
% beta) dla ka¿dego kana³u
    
    [freqs times chans os]=size(ersp_alpha); 
    for j=1:os% dla poszczególnych osób
        subj=STUDY.subject{j};
        stim=STUDY.condition;
        group=STUDY.group;
       % stim=STUDY_X.datasetinfo{j}.condition;
       % group=STUDY_X.datasetinfo{j}.group;
       
           f=fopen(saveDirPath_csv_ersp,'a');
     fprintf(f,'%s\t%s\t%s',subj, stim{1}, group{1});
     
           ff=fopen(saveDirPath_csv_ersp_Pfursch,'a');
     fprintf(ff,'%s\t%s\t%s',subj, stim{1}, group{1});
     
     ersp_alpha_os=ersp_alpha(:,:,:,j); %% dla obu kana³ów i 1 osoby
     ersp_alpha_os_mean_freq=squeeze(mean(ersp_alpha_os,1)); %% dla obu kana³ów i 1 osoby   - œrednia czêstotliwoœæ, wszystkie czasy
     ersp_alpha_os_mean=squeeze(mean(ersp_alpha_os_mean_freq,1)); % EWENTUALNIE DO ZMIANY - uœrednione po czasie
     
     ersp_beta_os=ersp_beta(:,:,:,j); %% dla obu kana³ów i 1 osoby
     ersp_beta_os_mean_freq=squeeze(mean(ersp_beta_os,1)); %% dla obu kana³ów i 1 osoby   - œrednia czêstotliwoœæ, wszystkie czasy
     ersp_beta_os_mean=squeeze(mean(ersp_beta_os_mean_freq,1)); % EWENTUALNIE DO ZMIANY - uœrednione po czasie

     
     ersp_Pfursch_alpha_os=ersp_Pfursch_alpha(:,:,:,j); %% dla obu kana³ów i 1 osoby
     ersp_Pfursch_alpha_os_mean_freq=squeeze(mean(ersp_Pfursch_alpha_os,1)); %% dla obu kana³ów i 1 osoby   - œrednia czêstotliwoœæ, wszystkie czasy
     ersp_Pfursch_alpha_os_mean=squeeze(mean(ersp_Pfursch_alpha_os_mean_freq,1)); % EWENTUALNIE DO ZMIANY - uœrednione po czasie
     
     ersp_Pfursch_beta_os=ersp_Pfursch_beta(:,:,:,j); %% dla obu kana³ów i 1 osoby
     ersp_Pfursch_beta_os_mean_freq=squeeze(mean(ersp_Pfursch_beta_os,1)); %% dla obu kana³ów i 1 osoby   - œrednia czêstotliwoœæ, wszystkie czasy
     ersp_Pfursch_beta_os_mean=squeeze(mean(ersp_Pfursch_beta_os_mean_freq,1)); % EWENTUALNIE DO ZMIANY - uœrednione po czasie
     
ersp_res_n=[];
ersp_Pfursch_res_n=[];

   for n=1:length(channelsList)

       % alpha       
       fprintf(f,'\t%f',ersp_alpha_os_mean(n));
       fprintf(ff,'\t%f',ersp_Pfursch_alpha_os_mean(n));
       %beta
       fprintf(f,'\t%f',ersp_beta_os_mean(n));
       fprintf(ff,'\t%f',ersp_Pfursch_beta_os_mean(n));
       
       ersp_res_n=[ersp_res_n ersp_alpha_os_mean(n) ersp_beta_os_mean(n)];
       ersp_Pfursch_res_n=[ersp_Pfursch_res_n ersp_Pfursch_alpha_os_mean(n) ersp_Pfursch_beta_os_mean(n)];
   
   end
       fprintf(f,'\r\n');
       fprintf(ff,'\r\n');
   
       ersp_res(j,:)=ersp_res_n;
       ersp_Pfursch_res(j,:)=ersp_Pfursch_res_n;
    
    end
   
        fclose(f);
        fclose(ff);
            
