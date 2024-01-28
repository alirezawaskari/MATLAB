clear; clc;

% Load data from imgProc.mat
load('imgProc.mat'); % Contains img, mean_val, std_val

% Load data from colorProc.mat
load('colorProc.mat'); % Contains blueChannel, greenChannel, redHist, blueHist, greenHist, numBins, colorFeatures, redChannel

% Load data from grayEdge.mat
load('grayEdge.mat'); % Contains edge_img, stats, glcm, gray_img

% Extract Texture Features
props = graycoprops(glcm, {'contrast', 'correlation', 'energy', 'homogeneity'});
contrast = props.Contrast;
correlation = props.Correlation;
energy = props.Energy;
homogeneity = props.Homogeneity;

% Calculate mean, standard deviation, skewness, and kurtosis for each channel
red_mean = mean(redHist);
red_std = std(redHist);
red_skewness = skewness(redHist);
red_kurtosis = kurtosis(redHist);

green_mean = mean(greenHist);
green_std = std(greenHist);
green_skewness = skewness(greenHist);
green_kurtosis = kurtosis(greenHist);

blue_mean = mean(blueHist);
blue_std = std(blueHist);
blue_skewness = skewness(blueHist);
blue_kurtosis = kurtosis(blueHist);

% Create a feature vector
feature_vector = [contrast, correlation, energy, homogeneity, red_mean, red_std, red_skewness, red_kurtosis, ...
                  green_mean, green_std, green_skewness, green_kurtosis, blue_mean, blue_std, blue_skewness, blue_kurtosis];

% Save new feature vector
save('new_feature_vector.mat', 'new_feature_vector');