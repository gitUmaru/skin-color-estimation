function [mean_rgb] = compute_skin_patch(image_rgb,mask_s)
    %% A: Image Segmentation - Binary image wiht threshold \nu
    ostu_threshold = graythresh(rgb2gray(image_rgb));
    init_mask = uint8(imbinarize(rgb2gray(image_rgb), ostu_threshold));

    ostu_thresh_image = (image_rgb .* init_mask);
    figure;
    imshow(ostu_thresh_image);
    %% B: Skin Detection - Removing non-skin pixels
    mask_x = zeros(size(image_rgb(:, :, 1)));
    mask_y = zeros(size(image_rgb(:, :, 1)));
    mask_z = zeros(size(image_rgb(:, :, 1)));


    img_HSV = rgb2hsv(ostu_thresh_image);
    mask_x(img_HSV(:, :, 1) <= 0.95) = 1;

    img_YCbCr = rgb2ycbcr(ostu_thresh_image);
    mask_y(img_YCbCr(:, :, 2) >= 90 & img_YCbCr(:, :, 2) <= 120) = 1;
    mask_z(img_YCbCr(:, :, 3) >= 140 & img_YCbCr(:, :, 3) <= 170) = 1;

    mask_cbcr = cat(3, mask_y, mask_z);
    mask = cat(3, mask_x, mask_cbcr);
    mask = sum(mask, 3);

    mask(mask < 3) = 0;
    mask(mask > 0) = 1;


    % New Skin Image with mask applied
    mask = uint8(mask) .* uint8(mask_s);

    final_thresh_image = mask .* ostu_thresh_image;

    figure;
    imshow(final_thresh_image);

    %% C. Estimate Skin Tone
    [index_x, index_y] = find(imbinarize(mask));
    index = [index_x, index_y];

    skin_pixel = zeros(size(index, 1), 3);
    for i = 1:size(index)
        color = final_thresh_image(index(i, 1), index(i, 2), :);
        skin_pixel(i, :) = reshape(color, 1, 3);
    end

    mean_rgb = mean(skin_pixel, 1);
end
