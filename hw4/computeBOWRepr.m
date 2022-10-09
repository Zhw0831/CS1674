function [bow_repr] = computeBOWRepr(features, means)

% Problem 1: initialize the bow variable
k = size(means,1);
bow_repr = zeros(1,k);                  % bow has the same length as the number of clusters

% Problem 2: map the the features to the closest clusters
dist = pdist2(features, means);         % calculate the distance between each feature and the clustering values
[~,closest] = min(dist, [], 2);         % get the row index (the ordinal of the cluster number) of the min distance value

% Problem 3: count how many features are mapped to each cluster
for i = 1:k
    bow_repr(i) = sum(closest == i);    % sum up the number of features that fall into each bin
end

% Problem 4: normalize the histogram
bow_repr = bow_repr / sum(bow_repr);
    

