clear; clc;

% Load your training data set
load(fullfile('feature', 'labels.mat'));

% Train the SVM model on the entire dataset
SVMModel = fitcecoc(all_feature_vectors, all_labels); % Or specify other parameters

% Predict labels for the entire dataset (including training samples)
predictedLabels = predict(SVMModel, all_feature_vectors);

% Calculate accuracy for the entire dataset
accuracy = sum(predictedLabels == all_labels) / numel(all_labels);
disp(['Accuracy: ', num2str(accuracy)]);
