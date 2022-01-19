clear
close all

%% Read each file and sort by ITA
image_directory = 'SD206-CenterCrop/';
imagefiles = dir(strcat(image_directory,'*.jpg'));      
nfiles = length(imagefiles);

fid = fopen("ita_metadata.csv",'w');

for i=1:nfiles
    [image, ita] = process(i,image_directory );
    
    fprintf(fid, '%s, %d\n', image, ita);
    
    % sort_im(image,ita)
end

fclose(fid);
