% specify a folder for the train set and the test set
data = fullfile('scenes_lazebnik');
imds = imageDatastore(data, 'IncludeSubfolders',true, 'LabelSource', 'foldernames');

% split the train/test data, 100 for train
numTrainingFiles = 100;
[imdsTrain,imdsTest] = splitEachLabel(imds,numTrainingFiles,'randomize');

% create a network with three types of layers
net_layers = [
    % a group of type A layers
    imageInputLayer([227 227 3])
    convolution2dLayer(11,50)
    reluLayer
    maxPooling2dLayer(3,'Stride',1)
    % a group of type B layers
    convolution2dLayer(5,60)
    reluLayer
    maxPooling2dLayer(3,'Stride',2)
    % a group of type C layers
    fullyConnectedLayer(8);
    softmaxLayer
    classificationLayer
  ];

% specify the training options

options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.0001, ...
    "MaxEpochs",5, ...
    "MiniBatchSize",64, ...
    "Plots","training-progress");

% train the network
nn = trainNetwork(imds, net_layers, options);

% compute test accuracy
pred = classify(nn,imdsTest);
true_labels = imdsTest.Labels;

accuracy = sum(pred == true_labels)/numel(true_labels);

disp(accuracy);






