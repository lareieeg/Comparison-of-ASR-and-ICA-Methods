function [EEG] = konwersja (EEG)
kontener = [];
sz=size(EEG.event,2);
for i=1:sz
    if ~strcmp(EEG.event(1,i).type,'boundary')
        if ischar(EEG.event(1,i).type)
	      kontener = [kontener str2num(EEG.event(1,i).type)];
        else
          kontener = [kontener EEG.event(1,i).type];   
        end
    else
      kontener = [kontener -1];  
    end;
end

for i=1:sz
     EEG.event(1,i).type=int16(kontener(i));     
   
end