function [EEG]=adjustFormat(EEG1,fileName,filePath)
EEG=EEG1;
EEG.filename=fileName;
EEG.filepath=filePath;

for i=1:1:size(EEG.chanlocs,2)
 EEG.chanlocs(i).ref='average';
end

EEG.saved='no';
end