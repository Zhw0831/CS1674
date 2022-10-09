function [predicted_labels_test] = findLabelsSVM(pyramids_train, labels_train, pyramids_test);
% train the model
model = fitcecoc(pyramids_train, labels_train);
% use the model just trained
predicted_labels_test = predict(model, pyramids_test);