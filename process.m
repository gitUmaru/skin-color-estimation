function [image, ita] = process(i,image_directory)
    close all;
    load('weights/skin_1000_iter.mat');

    imagefiles = dir(strcat(image_directory,'*.jpg'));      
    nfiles = length(imagefiles);    % Number of image files

    image = strcat(imagefiles(i).folder,'/',imagefiles(i).name);
    image_rgb = imread(image);
    %figure;
    %imshow(image_rgb)
    %% First Init Mask
    mask_s = test_step(image,centroid,covariance);
    %figure;
    %imshow(mask_s)
    %% Create composite mask and compute ITA
    mean_rgb = compute_skin_patch(image_rgb,mask_s);

    %figure;
    %patch([0 1 1 0],[0 0 1 1], mean_rgb./255);

    lab = rgb2lab(mean_rgb./255);
    ita = atan2((lab(1)-50),lab(2))*180/pi;
end