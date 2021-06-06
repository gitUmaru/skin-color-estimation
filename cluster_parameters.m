% calculate the cluster parameters
function [centroid, covariance] = cluster_parameters(skin_ycbcr, cluster_index)
skin_ycbcr = double(skin_ycbcr);

for i=min(cluster_index):max(cluster_index)
    index = cluster_index == i;
    cluster_color = skin_ycbcr(index, :);
    centroid(i,:) = mean(cluster_color); % Centroid
    difference = cluster_color - repmat(centroid(i,:), size(cluster_color,1), 1);
    N = size(difference,1);
    covariance(i,:,:) = (difference' * difference)/(N-1); % Covariance
end


