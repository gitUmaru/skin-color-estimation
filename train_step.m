%% Basic Initialisation
clear
close all

image_directory = 'dataset/train_im/';
mask_directory = 'dataset/train_ma/';

imagefiles = dir(strcat(image_directory,'*.jpg'));
nfiles = length(imagefiles);    % Number of image files

maskfiles =  dir(strcat(mask_directory,'*.jpg'));
mfiles = length(maskfiles);    % Number of mask files


mask = strcat(maskfiles(1).folder,'/',maskfiles(1).name);
image = strcat(imagefiles(1).folder,'/',imagefiles(1).name);

[centroid_i, covariance_i] = train(image, mask);

chkpnt = 1;

%% Train
for i=1:nfiles
    disp(i)
    count = i;
    mask = strcat(maskfiles(i).folder,'/',maskfiles(i).name);
    image = strcat(imagefiles(i).folder,'/',imagefiles(i).name);

    [centroid, covariance] = train(image, mask);

    if(size(centroid,1) == 2 && size(covariance,1) == 2)
        centroid = cat(1,centroid,[0 0 0]);
        covariance = cat(1,covariance,zeros(1,3,3));
    end

    centroid = (centroid + centroid_i)./2;
    covariance = (covariance + covariance_i)./2;

    centroid_i = centroid;
    covariance_i = covariance;

    if(mod(i,1000)==0)
        chkpnt_str = strcat('weights/skin_nfiles_chkpnt',int2str(i),'.mat');
        save(chkpnt_str,'centroid','covariance')
    end
end
%%
figure, axis([0 255 0 255 0 255]), xlabel('Y'), ylabel('Cb'), zlabel('Cr'), hold on;
for j=1:size(centroid,1)
    c = reshape(covariance(j,:,:), 3, 3);
    plot_gaussian_ellipsoid(centroid(j,:), c);
end

save weights/skin_nfiles_iter.mat centroid covariance

%% Train Step Definition
function [centroid, covariance] = train(image,mask)
    %% Read training images

    ground_truth = imread(mask);
    skin_mask = ground_truth(:,:,:);

    im = imread(image);
    im_ycbcr = rgb2ycbcr(im);
    im_flat = reshape(im_ycbcr, size(im_ycbcr,1)*size(im_ycbcr,2),3);
    [skin_mask_loc]= find(skin_mask);
    skin_ycbcr = double(im_flat(skin_mask_loc, :));
    %% STEP 1: Assign the samples to K (K=3 in this case) init clusters
    k = 3;

    % Optional Plot to physically see the individual image clusters
    % figure, plot3(skin_ycbcr(:,1),skin_ycbcr(:,2), skin_ycbcr(:,3),'.')
    % xlabel('Y'), ylabel('Cb'), zlabel('Cr')
    % axis([0 255 0 255 0 255])

    Y = skin_ycbcr(:,1);
    maxY=max(Y);
    minY=min(Y);
    step = round((maxY-minY)/k);
    %% STEP 2: Compute the centroid and coveriance matrix for each cluster
    cluster_index = zeros(k,1);
    cluster_index(Y < minY+step) = 1;

    for i=1:k
        idx = (minY +((i-1).*step) < Y);
        cluster_index(idx) = i;
    end
    %% STEP 3: For each sample x_j (j=1:N) compute the k Mahalanobis distances ot the k clusters (i=1:k)
    [centroid, covariance] = cluster_parameters(skin_ycbcr, cluster_index);

    iter = 1;
    while (iter <10)
        [cluster_index] = cluster_reassign(skin_ycbcr, centroid, covariance);
        [centroid, covariance] = cluster_parameters(skin_ycbcr, cluster_index);
        iter = iter+1;
    end

    % STEP 4: Repeat steps 2-3
end
