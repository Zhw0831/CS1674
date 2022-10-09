function [predicted_labels_test] = findLabelsKNN(pyramids_train, labels_train, pyramids_test, k);

distance = zeros(size(pyramids_test,1),size(pyramids_train,1));
labels = zeros(size(pyramids_test,1),1);
neighbors = zeros(1,k);

% for each test image
for i = 1:size(distance,1)
    % compute the Euclidean 
    for j = 1:size(distance,2)
        distance(i,j) = pdist2(pyramids_test(i,:),pyramids_train(j,:));
    end
    % sort the distance in ascending order
    [~,rank] = sort(distance(i,:),'ascend');
    % find the labels for k nearest neighbors
    for m = 1:k
        neighbors(m) = labels_train(rank(m));
    end
    % find the label has the most votes
    label = mode(neighbors);
    labels(i) = label;
end

predicted_labels_test = labels;

