%% Basic Initialisation
close all;
clear all;
load cluster_predicted_masks/mask_s
load weights/skin_1000_iter

image_directory = 'skin_lesion/';


imagefiles = dir(strcat(image_directory,'*.jpg'));      
nfiles = length(imagefiles);    % Number of image files

i = 11;

image = strcat(imagefiles(i).folder,'/',imagefiles(i).name);
image_rgb = imread(image);
imshow(image_rgb)

mask_s = test_step(image,centroid,covariance);
str = erase(sprintf('cluster_predicted_masks/%s.mat',"mask_s"),".jpg");
save(str,"mask_s")

mean_rgb = compute_skin_patch(image_rgb,mask_s);

figure;
patch([0 1 1 0],[0 0 1 1], mean_rgb./255);

lab = rgb2lab(mean_rgb./255);
ita = atan2((lab(1)-50),lab(2))*180/pi;
disp(ita)
