pyramids_train = [];
level_0_train = [];
level_1_train = [];

% find the representations for train images
for i = 1:size(train_images)
    [pyramid,level_0,level_1] = computeSPMRepr(train_images(i,:),train_sift{i},means);
    pyramids_train(i,:) = pyramid;
    level_0_train(i,:) = level_0;
    level_1_train(i,:) = level_1;
end

pyramids_test = [];
level_0_test = [];
level_1_test = [];

% find the representations for test images
for i = 1:size(test_images)
    [pyramid,level_0,level_1] = computeSPMRepr(test_images(i,:),test_sift{i},means);
    pyramids_test(i,:) = pyramid;
    level_0_test(i,:) = level_0;
    level_1_test(i,:) = level_1;
end

% use SVM classifier
predict_pyramid = findLabelsSVM(pyramids_train,train_labels,pyramids_test);
predict_level_0 = findLabelsSVM(level_0_train,train_labels,level_0_test);
predict_level_1 = findLabelsSVM(level_1_train,train_labels,level_1_test);

% compute accuracy by the fraction of correct labels prediction / total
% number of labels
total = size(test_labels,1);
disp('accuracy for full SPM');
accuracy_pyra = sum(predict_pyramid==test_labels)/total
disp('accuracy for level 0');
accuracy_level_0 = sum(predict_level_0==test_labels)/total
disp('accuracy for level 1');
accuracy_level_1 = sum(predict_level_1==test_labels)/total






