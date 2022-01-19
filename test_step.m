function [skin_predicted_mask] = test_step(image,centroid,covariance)
    im = imread(image);
    im_ycbcr = rgb2ycbcr(im);
    im_ycbcr = double(im_ycbcr);
    im_ycbcr_flat = reshape(im_ycbcr, size(im_ycbcr,1)*size(im_ycbcr,2),3); % linearize

    for i=1:size(centroid,1)

        centroid_x_slice = centroid(i,:);
        covariance_3x3 = reshape(covariance(i,:,:), 3, 3);

        delta = im_ycbcr_flat - repmat(centroid_x_slice, size(im_ycbcr_flat,1), 1);
        Mahalanobis_dist(:,i) = sum(delta/(covariance_3x3) .* delta, 2);
    end

    dist_min = min(Mahalanobis_dist, [], 2);

    skin_predicted = dist_min < 10;
    skin_predicted_mask = zeros(size(im,1)*size(im,2),1);
    skin_predicted_mask(skin_predicted,1) = 1;
    skin_predicted_mask = reshape(skin_predicted_mask, size(im,1), size(im,2));
    %figure;
    %imshow(skin_predicted_mask)
end
