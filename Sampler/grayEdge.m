clear;clc

load('imgProc.mat')

% Convert the image to grayscale if it's not already in grayscale
gray_img = rgb2gray(img); % If the image is RGB

% Compute GLCM with specific parameters (you can adjust these parameters)
glcm = graycomatrix(gray_img, 'Offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true);

% Calculate GLCM properties (contrast, correlation, energy, homogeneity)
stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
disp(['Contrast: ', num2str(stats.Contrast)]);
disp(['Correlation: ', num2str(stats.Correlation)]);
disp(['Energy: ', num2str(stats.Energy)]);
disp(['Homogeneity: ', num2str(stats.Homogeneity)]);

% Apply Canny edge detection
edge_img = edge(gray_img, 'Canny');

% Display the edges
% imshow(edge_img);

save grayEdge.mat