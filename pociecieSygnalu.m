function [danePociete]=pociecieSygnalu(dane)
d={};

m=size(dane,1);
n=size(dane,2);

pom=int32(m/512)*512;

for i=1:512:pom-1024
   d=[d; dane(i:1:i+1023,:)]; 
end
danePociete=d;
end