function [channs]= findChannelsNo(channelsList,EEG)

l=struct2cell(EEG.chanlocs);
l=squeeze(l(1,:,:));

for i=1:length(channelsList)
    a = strcmp(l,channelsList{i});
    channs(i)=find(a==1);
end