%% Train, Evaluate, and Apply Image Category Classifier
%
%% 
% Load two image categories.
%setDir  = fullfile(toolboxdir('vision'),'visiondata','imageSets');

%Essentially - create two folders, fill them with images.
%The categoryClassifier will be trained on both folders as separate
%categories
%The names of each category will be taken directly from the folders names
 setDir = 'C:\Users\ShopBot\Documents\MATLAB\IMGPROC_MTLAB\visiondata';
imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
%% 
% Split the data set into a training and test data. Pick 70% of images 
% from each set for the training data and the remainder  30% for the 
% test data.
%Feel free to tweak this line below
[trainingSet,testSet] = splitEachLabel(imds,0.7,'randomize');
%% 
% Create bag of visual words.
bag = bagOfFeatures(trainingSet);
%% 
% Train a classifier with the training sets.
categoryClassifier = trainImageCategoryClassifier(trainingSet,bag);
%% 
% Evaluate the classifier using test images. Display the confusion matrix.
confMatrix = evaluate(categoryClassifier,testSet)
%% 
% Find the average accuracy of the classification.
mean(diag(confMatrix))

%you can change the name of the model by changing exModelv2 to whatever
%you want.
%This will save exModelv2 as a .mat. Loading it into a workspace loads the 
%categoryClassifier variable.
save exModelv2 categoryClassifier;

%Prediction Code
%[labelIdx, score] = predict(categoryClassifier,img);
%% 
% Display the classification label.
%categoryClassifier.Labels(labelIdx);