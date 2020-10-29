function [EEG] = flt_brake_rem_2 (EEG, saveDirPath, fName,a,c)
%a - poczatek c-koniec
blokiDobre=[a,c];%event types dla poczatku i konca bloku, ktory chcemy zostawic w sygnale. Reszta bedzie wycinana
margines=1;%margines +/- sekund przed/po evencie


    %usuwanie przerw
    marginesPts=EEG.srate*margines;
    event=cell2mat({EEG.event.type});%same numery eventow
    latencies = [];%tu beda poczatki i konce blokow liczone w punktach
    for b=1:size(blokiDobre,1)
        evStart=blokiDobre(b,1);
        evStop=blokiDobre(b,2);
        latencies(b,:) = [EEG.event(event==evStart).latency-marginesPts EEG.event(event==evStop).latency+marginesPts];
    end
    EEG = pop_select(EEG,'point',latencies);%glowna funkcja do wycinania blokow z sygnalu ciaglego
  