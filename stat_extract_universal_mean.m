%Uniwersalny skrypt do wyciagniecia danych do analizy statystycznej.
%Przed wykonaniem skryptu ustaw potrzebne parametry w "Select/Edit Study
%Designs", czyli podaj filtry zmiennych.
%Skrypt sam nazywa zmienne wg nazw w StudyDesign
czasPocz = 280; %pocz¹tek przedzia³u czasowego do uœrednienia
czasKonc = 400; %koniec przedzia³u czasowego do uœrednienia

elektrody = {'F3' 'Fz' 'F4' 'C3' 'Cz' 'C4' 'P3' 'Pz' 'P4' 'O1' 'Oz' 'O2'};
plikStat=['stats_P3' num2str(czasPocz) '-' num2str(czasKonc) '.csv'];
%Format pliku: w weirszach: osoby badane, w kolumnach: zmienne
%Dla uk³adów 2x2: 
%1: ZN1(1)-ZN2(1);
%2: ZN1(2)-ZN2(1);
%3: ZN1(1)-ZN2(2);
%4:ZN1(2)-ZN2(2).
%-------------------------
STUDY = pop_erpparams(STUDY, 'topotime',[]);
[STUDY erpdata erptimes] = std_erpplot(STUDY,ALLEEG,'channels', elektrody, 'noplot','off','averagechan','off');

% [STUDY erpdata erptimes] = std_erpplot(STUDY,ALLEEG,'channels', {'O1'}, 'noplot','off','averagechan','off');
% std_plotcurve(erptimes, erpdata, 'plotconditions', 'together', 'plotstderr', 'on', 'figure', 'on'); 

fid=fopen(plikStat,'w');
fprintf(fid,'subj\t');
for zn1=1:numel(STUDY.design(STUDY.currentdesign).variable(1).value)
    for zn2=1:numel(STUDY.design(STUDY.currentdesign).variable(2).value)
        for el=1:numel(elektrody)
           fprintf(fid,'%s_%s_%s\t', num2str(STUDY.design(STUDY.currentdesign).variable(1).value{zn1}),num2str(STUDY.design(STUDY.currentdesign).variable(2).value{zn2}),elektrody{el});
        end
    end
end
fprintf(fid,'\r\n');

id=erptimes>=czasPocz & erptimes<=czasKonc;

wynik=[];
subj=STUDY.subject';
for zn1=1:size(erpdata,1)
    for zn2=1:size(erpdata,2)
        dane=erpdata{zn1,zn2};
        daneMean=squeeze(mean(dane(id,:,:),1))';
        wynik=horzcat(wynik,daneMean);
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