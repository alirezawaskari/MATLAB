% Load your training data set
load(fullfile('feature', 'labels.mat'));

% Define the SVM model
SVMModel = fitcecoc(all_feature_vectors, all_labels); % Or specify other parameters

% Perform 5-fold cross-validation
cv = cvpartition(all_labels, 'KFold', 5); % 5-fold cross-validation
accuracy = zeros(cv.NumTestSets, 1);

for i = 1:cv.NumTestSets
    idxTrain = training(cv, i); % Get training indices for this fold
    idxTest = test(cv, i); % Get test indices for this fold
    
    % Train the model on the training subset
    SVMModelFold = fitcecoc(all_feature_vectors(idxTrain, :), all_labels(idxTrain));
    
    % Predict labels for the test subset
    predictedLabels = predict(SVMModelFold, all_feature_vectors(idxTest, :));
    
    % Calculate accuracy for this fold
    accuracy(i) = sum(predictedLabels == all_labels(idxTest)) / numel(idxTest);
end

% Calculate average accuracy across folds
meanAccuracy = mean(accuracy);
disp(['Mean Accuracy: ', num2str(meanAccuracy)]);
