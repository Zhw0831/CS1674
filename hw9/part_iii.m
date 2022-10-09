% specify a folder for the train set and the test set
data = fullfile('scenes_lazebnik');
imds = imageDatastore(data, 'IncludeSubfolders',true, 'LabelSource', 'foldernames');

% split the train/test data, 3 or 10 for train
numTrainingFiles = 3;
% numTrainingFiles = 10;
[imdsTrain,imdsTest] = splitEachLabel(imds,numTrainingFiles,'randomize');

% create the augmenter
% below is the best result combination when the number of training images
% per class is 3
aug = imageDataAugmenter( ...
    'RandRotation',[0 360], ...
    'RandScale',[0.5 1]);
% below is the best result combination when the number of training images
% per class is 10
% aug = imageDataAugmenter( ...
%     'RandXTranslation',[-5 5], ...
%     'RandScale',[0.5 1]);

% data augmentation
imageSize = [227 227 3];
imdsTrain = augmentedImageDatastore(imageSize,imdsTrain,'DataAugmentation',aug);

% visualize augmentation
minibatch = preview(imdsTrain); 
imshow(imtile(minibatch.input));

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
