clear;clc

load('imgProc.mat')

% Split the image into its RGB channels
redChannel = img(:, :, 1);
greenChannel = img(:, :, 2);
blueChannel = img(:, :, 3);

% Calculate histograms for each color channel
numBins = 256; % Number of bins for the histogram
redHist = imhist(redChannel, numBins);
greenHist = imhist(greenChannel, numBins);
blueHist = imhist(blueChannel, numBins);

% Display the histograms or perform further analysis
% For instance, concatenate histograms to form a single feature vector
colorFeatures = [redHist; greenHist; blueHist];

save colorProc.mat