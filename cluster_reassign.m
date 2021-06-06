function [cluster_index] = cluster_reassign(skin_ycbcr, centroid, covariance)

for i=1:size(centroid,1)

    centroid_x_slice = centroid(i,:);
    covar_3x3 = reshape(covariance(i,:,:), 3, 3);
    delta = skin_ycbcr - repmat(centroid_x_slice, size(skin_ycbcr,1), 1);
    Mahalanobis_dist(:,i) = sum(delta/(covar_3x3) .* delta, 2);
    
    
end

[~, cluster_index] = min(Mahalanobis_dist,[],2);
