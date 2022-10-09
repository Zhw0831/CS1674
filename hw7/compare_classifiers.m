total_train = size(train_labels,1);
total_test = size(test_labels,1);

% apply SVM classifiers on train set
svm_labels_train = findLabelsSVM(pyramids_train,train_labels,pyramids_train);
% on test set
svm_labels_test = findLabelsSVM(pyramids_train,train_labels,pyramids_test);
% compute accuracy for SVM
accuracy_SVM_train = sum(svm_labels_train==train_labels)/total_train;
accuracy_SVM_test = sum(svm_labels_test==test_labels)/total_test;

accuracy_KNN_train = [];
accuracy_KNN_test = [];
counter = 1;
% apply KNN classifier on train set
for k = 1:2:21
    knn_labels_train = findLabelsKNN(pyramids_train,train_labels,pyramids_train,k);
    accuracy_KNN_train(1,counter) = sum(knn_labels_train==train_labels)/total_train;
    knn_labels_test = findLabelsKNN(pyramids_train,train_labels,pyramids_test,k);
    accuracy_KNN_test(1,counter) = sum(knn_labels_test==test_labels)/total_test;
    % increment the index counter
    counter = counter + 1;
end

% plot accuracy of the classifiers
figure;
% for SVM accuracy values, convert to the size that spans the interval
plot((1:21),accuracy_SVM_train*ones(1,21));
hold on;
plot((1:21),accuracy_SVM_test*ones(1,21));
hold on;
plot((1:2:21),accuracy_KNN_train);
hold on;
plot((1:2:21),accuracy_KNN_test);
hold on;

xlabel("k values");
ylabel("accuracy");
legend("SVM Train Accuracy","SVM Test Accuracy", "KNN Train Accuracy", "KNN Test Accuracy");



    
