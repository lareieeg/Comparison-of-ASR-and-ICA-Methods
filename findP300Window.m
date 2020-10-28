function [P300Window P300Loc] = findP300Window (pathname_dir, fileName_X, fileName_O, channelsList, signal_ind_start)



% X
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    [STUDY_X ALLEEG_X] = pop_loadstudy('filename', fileName_X, 'filepath', pathname_dir);
    CURRENTSTUDY_X = 1; EEG_X = ALLEEG; CURRENTSET_X = [1:length(EEG_X)];
    [STUDY_X ALLEEG_X] = std_precomp(STUDY_X, ALLEEG_X, {},'interp','on','recompute','on','erp','on');
    [STUDY_X erpdata_X erptimes_X] = std_erpplot(STUDY_X,ALLEEG_X,'channels',cellstr(channelsList)); % erp - wszystkie osoby, 1 elektroda

% O
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    [STUDY_O ALLEEG_O] = pop_loadstudy('filename', fileName_O, 'filepath', pathname_dir);
    CURRENTSTUDY_O = 1; EEG_O = ALLEEG; CURRENTSET_O = [1:length(EEG_O)];
    [STUDY_O ALLEEG_O] = std_precomp(STUDY_O, ALLEEG_O, {},'interp','on','recompute','on','erp','on');
    [STUDY_O erpdata_O erptimes_O] = std_erpplot(STUDY_O,ALLEEG_O,'channels',cellstr(channelsList)); % erp - wszystkie osoby, 1 elektroda

% uœredniane (dla ka¿dej elektrody oddzielnie): 
% po elektrodach
% 1. dla poszcz. osób
% 2. miêdzy osobami

[pkt_X os_X]=size(erpdata_X{1}); % 1 elektroda
[pkt_O os_O]=size(erpdata_O{1}); % 1 elektroda

if (length(pkt_X)==length(pkt_O)  && length(os_X)==length(os_O) && all(strcmp(STUDY_X.subject,STUDY_O.subject))) % wymiary zgodne
   for j=1:os_X% dla poszczególnych osób
       matr_el_x=erpdata_X{1}(:,j); % dane dla 1 osoby ( 1 elektroda) (175x1)
   %    matr_x=mean(matr_el_x,2); % uœrednij po elektrodach
       matr_el_o=erpdata_O{1}(:,j); % dane dla 1 osoby ( 1 elektroda) (175x1)
       mean_erp_xo(:,j)=(matr_el_x+matr_el_o)/2; % uœrednione dane dla 1 osoby dla x i o (175x1)       
   end
   mean_erp=squeeze(mean(mean_erp_xo,2)); % uœredniamy po osobach
 %  mean_erp=squeeze(mean(mean_erp_os,2)); % uœredniamy po elektrodach -
 %  tylko 1 elektroda
   figure; plot(erptimes_O,mean_erp); hold on;
    [pks,locs] = findpeaks(mean_erp); % w puktach
    plot(locs*4-100,pks,'*'); % przeliczyæ na czas z uwzglêdnieniem 100ms baseline
      [P300Window locs_max]=max(pks);
      P300Window=(P300Window/2)*11;
      P300Loc=locs(locs_max); % punkty z uwzglêdnieniem baseline, czyli zaczynaj¹c od -100ms
end


