clear; clc;

% Specify the directory containing your feature .mat files
parent_directory = 'path_to_directory'; % Replace 'path_to_directory' with your directory path
subdirectories = {'sub1', 'sub2', 'sub3', 'sub3', ...}; % Replace them with your subdirectories

% Loop through each subdirectory
for subdir_idx = 1:numel(subdirectories)
    % Get the current subdirectory
    current_subdir = subdirectories{subdir_idx};
    
    % Define the directory path for subdirectories
    directory = fullfile(parent_directory, current_subdir);
    dest = fullfile('destination', current_subdir); % Replace 'destination' with your subdirectories

    % Create a destination directory if it doesn't exist
    if ~exist(dest, 'dir')
        mkdir(dest);
    end
    
    % List all .mat files in the current subdirectory
    files = dir(fullfile(directory, '*.mat'));
    
    % Loop through each data file
    for i = 1:numel(files)
        % Load the data from the .mat file
        loaded_data = load(fullfile(directory, files(i).name));

        img = loaded_data.img; % Assuming 'img' is the variable name in the .mat file

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
        
        % Define the filename for saving .mat file
        [~, filename, ~] = fileparts(files(i).name); % Extract filename without extension
        save_filename = fullfile(dest, [filename, '_colors.mat']);
        
        % Save the edge image as a .mat file
        save(save_filename);
    end
    
    % Clear the workspace after each subdirectory iteration
    clearvars -except parent_directory subdirectories
end