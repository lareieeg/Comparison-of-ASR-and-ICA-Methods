 function [max_peak, mean_ampl, var_ampl, erp_snr, max_locs]=erp4(pathname_dir,fileName, saveDirPath_csv_erp_peaks, saveDirPath_csv_erp_means, saveDirPath_csv_erp_variance, saveDirPath_csv_erp_snr, results_dir_full, channelsList, p300WindowRange, signal_ind_start)

    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    [STUDY ALLEEG] = pop_loadstudy('filename', fileName, 'filepath', pathname_dir);
    CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
    [STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on');
    EEG = eeg_checkset( EEG );
    [STUDY erpdata erptimes] = std_erpplot(STUDY,ALLEEG,'channels',cellstr(channelsList)); % erp - wszystkie osoby, 1 elektroda
    [STUDY EEG] = pop_savestudy( STUDY, EEG, 'filename',strcat(fileName(1:end-6),'_afterERP.study'),'filepath',results_dir_full);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];


    srate=ALLEEG(1).srate;
    P300_start=p300WindowRange(1);
    P300_end=p300WindowRange(2);
%     P300_start=floor(srate*p300WindowRange(1)/1000);
%     P300_end=ceil(srate*p300WindowRange(2)/1000);
    
    
    [pkt el os]=size(erpdata{1}); 
    for j=1:os% dla poszczególnych osób
        subj=STUDY.subject{j};
        stim=STUDY.condition;
        group=STUDY.group;
       % stim=STUDY_X.datasetinfo{j}.condition;
       % group=STUDY_X.datasetinfo{j}.group;
       
           f=fopen(saveDirPath_csv_erp_peaks,'a');
     fprintf(f,'%s\t%s\t%s',subj, stim{1}, group{1});
    ff=fopen(saveDirPath_csv_erp_means,'a');
     fprintf(ff,'%s\t%s\t%s',subj, stim{1}, group{1});
    fff=fopen(saveDirPath_csv_erp_variance,'a');
     fprintf(fff,'%s\t%s\t%s',subj, stim{1}, group{1});
    ffff=fopen(saveDirPath_csv_erp_snr,'a');
     fprintf(ffff,'%s\t%s\t%s',subj, stim{1}, group{1});
     


       matr_el=(erpdata{1}(P300_start:P300_end,:,j)); % wyniki dla wszystkich elektrod
       matr_el_baseline=(erpdata{1}(1:signal_ind_start,:,j));
   %    matr_x=mean(matr_el_x,2); % uœrednij po elektrodach
  
   for n=1:length(channelsList)
            % wyœwietl ca³oœæ
            matrix_all=erpdata{1}(:,n,j);
            figure; subplot(2,1,1); plot(matrix_all,'r'); 
            subplot(2,1,2); plot(matr_el(:,n),'r'); 
       [pks,locs] = findpeaks(matr_el(:,n)); %  dla kanalow!
       try
           [max_peak(j,n) ind]=max(pks);
           max_locs(j,n)=locs(ind);
       catch 
           max_peak(j,n)=NaN;  
       end
       mean_ampl(j,n)=mean(matr_el(:,n));
       var_ampl(j,n)=var(matr_el(:,n));
       var_base(j,n)=var(matr_el_baseline(:,n));
       erp_snr(j,n)=mean_ampl(j,n)/var_base(j,n);
       
       fprintf(f,'\t%f',max_peak(j,n));
       fprintf(ff,'\t%f',mean_ampl(j,n));
       fprintf(fff,'\t%f',var_ampl(j,n));
       fprintf(ffff,'\t%f',erp_snr(j,n));
       
   end
       fprintf(f,'\r\n');
       fprintf(ff,'\r\n');
       fprintf(fff,'\r\n');
       fprintf(ffff,'\r\n');
   
    
    end
   
        fclose(f);
        fclose(ff);    
        fclose(fff);
        fclose(ffff);
            
% 
% 
% 
% 
% % after baseline
% 
% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% [STUDY ALLEEG] = pop_loadstudy('filename', 'ERPDataAfterBaseline_ASR_O.study', 'filepath', 'C:\MPW\EEG\ASR-artefakty\Dane EEGLab\results_withoutBaseline');
% CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
% 
% [STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on');
% 
% [STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [-100 0] });
% 
% 
% % dla ka¿dej elektrody oddzielnie 
% channelsList={'FP1';'FP2';'F7';'F3';'FZ';'F4';'F8';'FC5';'FC1';'FC2';'FC6';'T7';'C3';'Cz';'C4';'T8';'TP9';'CP5';'CP1';'CP2';'CP6';'TP10';'P7';'P3';'PZ';'P4';'P8';'PO9';'O1';'Oz';'O2';'PO10';'AF7';'AF3';'AF4';'AF8';'F5';'F1';'F2';'F6';'FT9';'FT7';'FC3';'FC4';'FT8';'FT10';'C5';'C1';'C2';'C6';'TP7';'CP3';'CPZ';'CP4';'TP8';'P5';'P1';'P2';'P6';'PO7';'PO3';'POz';'PO4';'PO8';'FCz'}
% 
% [STUDY erpdata erptimes] = std_erpplot(STUDY,ALLEEG,'channels',cellstr(channelsList{1})); % erp - wszystkie osoby, 1 elektroda
% x=erpdata{1,1}(:,1);
% figure; plot(x);hold on;
% [pks,locs,w,p] = findpeaks(x);
% plot(locs,pks,'*');
% 
% [TF,P] = islocalmin(x);
% 
% std_plotcurve(erptimes, erpdata, 'plotconditions', 'together', 'plotstderr', 'on', 'figure', 'on');
% eeglab redraw;
% 
% 
% % study no baseline
% %[ALLEEG2 EEG2 CURRENTSET2 ALLCOM2] = eeglab;
% [STUDY2 ALLEEG2] = pop_loadstudy('filename', 'allERPDataNoBaseline_ASR_O.study', 'filepath', 'c:\MPW\EEG\ASR-artefakty\Dane EEGLab\results_Baseline');
% CURRENTSTUDY2 = 1; EEG2 = ALLEEG2; CURRENTSET2 = [1:length(EEG2)];
% 
% [STUDY2 ALLEEG2] = std_precomp(STUDY2, ALLEEG2, {},'interp','on','recompute','on','erp','on','erpparams',{'rmbase' [-100 0] });
