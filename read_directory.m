
pathname='data';
results_dir='results_divided';

filenam=dir(pathname); 
filename=struct2cell(filenam);  
filenames=filename(1,3:end)'; 
len=length(filenames);
ci=len;

for i=1:ci
    disp(filenames{i});
end  
 

