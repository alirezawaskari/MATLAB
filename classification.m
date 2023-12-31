clear; clc;

% Load your training data set
load(fullfile('feature', 'labels.mat'));

% Load your sample of which you want to use for prediction
load('new_feature_vector.mat')

% Train the SVM model on the entire dataset
SVMModel = fitcecoc(all_feature_vectors, all_labels); % Or specify other parameters

% Predict fault types using the trained model
predictedFaultTypes = predict(SVMModel, new_feature_vector);

% Display or utilize the predicted fault types
disp(predictedFaultTypes);