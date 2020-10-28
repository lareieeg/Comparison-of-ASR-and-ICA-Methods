






elektrody = {'C3'  'C4'};
freqs=[14 30];
plikStat=['stats_ERSP_beta.csv'];
%Format pliku: w weirszach: osoby badane, w kolumnach: zmienne
%Dla uk³adów 2x2: 
%1: ZN1(1)-ZN2(1);
%2: ZN1(2)-ZN2(1);
%3: ZN1(1)-ZN2(2);
%4:ZN1(2)-ZN2(2).
%-------------------------
STUDY = pop_erspparams(STUDY, 'freqrange',[2 35] );
[STUDY erspdata ersptimes erspfreqs]=std_erspplot(STUDY,ALLEEG,'channels',elektrody);


fid=fopen(plikStat,'w');
fprintf(fid,'subj\t');
for zn1=1:numel(STUDY.design(STUDY.currentdesign).variable(1).value)
    for zn2=1:numel(STUDY.design(STUDY.currentdesign).variable(2).value)
        for el=1:numel(elektrody)
           fprintf(fid,'%s_%s_%s_signal\t', num2str(STUDY.design(STUDY.currentdesign).variable(1).value{zn1}),num2str(STUDY.design(STUDY.currentdesign).variable(2).value{zn2}),elektrody{el});
           fprintf(fid,'%s_%s_%s_noise\t', num2str(STUDY.design(STUDY.currentdesign).variable(1).value{zn1}),num2str(STUDY.design(STUDY.currentdesign).variable(2).value{zn2}),elektrody{el});
        end
    end
end
fprintf(fid,'\r\n');

id_noise=ersptimes<=0;
id_signal=ersptimes>0;

id_freqs=erspfreqs>=freqs(1) & erspfreqs<=freqs(2);

wynik=[];
subj=STUDY.subject';
for zn1=1:size(erspdata,1)
    for zn2=1:size(erspdata,2)
        for el=1:numel(elektrody)
            dane=erspdata{zn1,zn2};
            daneAbs_noise=abs(dane(id_freqs,id_noise,el,:));
            daneAbsMax_noise=squeeze(max(squeeze(max(daneAbs_noise,[],1)),[],1))';
            daneAbs_signal=abs(dane(id_freqs,id_signal,el,:));
            daneAbsMax_signal=squeeze(max(squeeze(max(daneAbs_signal,[],1)),[],1))';

            wynik=horzcat(wynik,daneAbsMax_signal,daneAbsMax_noise);
        end
    end
end

for os=1:size(wynik,1)
    fprintf(fid,'%s\t',subj{os});
    for i=1:size(wynik,2)
        fprintf(fid,'%f\t',wynik(os,i));
    end
    fprintf(fid,'\r\n');
end
fclose(fid);
disp('Done.')