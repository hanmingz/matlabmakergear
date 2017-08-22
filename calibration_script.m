%Vision Calibration Script
%Run this code to see a) what the camera sees
% b) The size it sees it at 
% c) whether it is classifying the current state correctly
% Adjust surrounnding conditions to make extruder glow
% Only a small amount of adjustment needs to be done to make sure the vision works 

%uEyeMexObj is the camera object and supports the method Grab
%which returns the image that the camera sees as a matrix
obj = uEyeMexObj;
%load exModel.mat; - if you want to load the old model
load exModelv2.mat;

while true
    tic
    h = obj.Grab;
    
    A = h;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %These parameters can be changed to facilitate faster processing
    %See parameters.txt for a full list of parameters to use
    A(:, 800:1600) = [];
    A(:,1:650) = [];
        
    A(900:1200,:) = [];
    A(1:600,:) = [];
    background = imopen(A,strel('square',200));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    I2 = A - background;
    I3 = imadjust(I2);
    imshow(I3);
    
    %After loading exModelv2, the classifier is loaded onto the workspace
    %with the variable categoryClassifier
    %You can use this to predice the state of the extruder
    [labelIdx, score] = predict(categoryClassifier, I3);
    
    %Displaying the information: Not/Extruding and Time taken to predict
    resultOfClassification = categoryClassifier.Labels(labelIdx);
    disp(resultOfClassification);
    elap = toc
    disp(elap);
    disp('time to predict');
    
end
