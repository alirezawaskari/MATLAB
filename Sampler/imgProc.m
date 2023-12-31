clear;clc

img = imread('output_a_LL_fault_bus2.png');

% imshow(img);

mean_val = mean(img(:));
disp(['Mean pixel value: ', num2str(mean_val)]);

std_val = std(double(img(:)));
disp(['Standard deviation of pixel values: ', num2str(std_val)]);

save imgProc.mat