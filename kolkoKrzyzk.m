%krzyzyk={};
%tab=[1 2; 3 4];
%krzyzyk=[krzyzyk; tab];
%tab=[1 2; 3 4];
%krzyzyk=[krzyzyk; tab];

krzyzyk={};
kolko={};
dl=size(EEG.event,2);
electrodes=size(EEG.data,1);
suma=0;
for i=1:dl
    if EEG.event(1,i).type==11 %krzyzk
        sample=EEG.event(1,i).latency
        pom=EEG.data(1:1:electrodes,sample:1:sample+375-1);
        krzyzyk=[krzyzyk;pom];
    end;
    if  EEG.event(1,i).type==12 %kolko
        suma=suma+1;
        sample=EEG.event(1,i).latency
        pom=EEG.data(1:1:electrodes,sample:1:sample+375-1);
        kolko=[kolko;pom];
    end;
end;