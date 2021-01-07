% You'll need to download AlexNet
net = alexnet;
layers = net.Layers;

% Creates a layer for the 3 galaxy classes
fc = fullyConnectedLayer(3);

% Changes two AlexNet layers to that it only finds
% features for our 3 classes, not the original 1000
layers(23) = fc;
layers(25) = classificationLayer;

% Set some parameters for the training
opts = trainingOptions('sgdm','InitialLearnRate',0.001,'Verbose',true,'Plots','training-progress');

% Creates a datastore from the images in the 
% 'Data_Train' folder in this directory
% A datastore makes it easier to deal with many images
gals_temp = imageDatastore('Data_Train/','IncludeSubfolders',true,'LabelSource','foldernames');

% Resizes the images to be what AlexNet expects
gals = augmentedImageDatastore([227 227], gals_temp);

% Trains the modified AlexNet and saves it as 
% a new network called GalaxyNet
[galaxynet,info] = trainNetwork(gals, layers, opts);