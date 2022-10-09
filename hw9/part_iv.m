% specify a folder for the train set and the test set
data = fullfile('scenes_lazebnik');
imds = imageDatastore(data, 'IncludeSubfolders',true, 'LabelSource', 'foldernames');

% split the train/test data, 10 for train
numTrainingFiles = 10;
[imdsTrain,imdsTest] = splitEachLabel(imds,numTrainingFiles,'randomize');

% load pre-trained network
net = alexnet;

% transfer all layers up to but excluding the FC6 layer
layersTransfer = net.Layers(1:16);

% build the layers
layers = [
    layersTransfer
    fullyConnectedLayer(8);
    softmaxLayer
    classificationLayer];

% freeze the transferred layers
layers(2).WeightLearnRateFactor = 0;
layers(6).WeightLearnRateFactor = 0;
layers(10).WeightLearnRateFactor = 0;
layers(12).WeightLearnRateFactor = 0;
layers(14).WeightLearnRateFactor = 0;


% specify the training options
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.0001, ...
    "MaxEpochs",5, ...
    "MiniBatchSize",64);

% train the network
nn = trainNetwork(imds, layers, options);

% compute test accuracy
pred = classify(nn,imdsTest);
true_labels = imdsTest.Labels;

accuracy = sum(pred == true_labels)/numel(true_labels);

disp(accuracy);

