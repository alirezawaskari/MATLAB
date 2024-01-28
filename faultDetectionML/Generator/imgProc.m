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
    
    % List all .png files in the current subdirectory
    files = dir(fullfile(directory, '*.png'));
    
    % Loop through each data file
    for i = 1:numel(files)
        % Extract the filename without extension
        [~, filename, ~] = fileparts(files(i).name); % Extract filename without extension
        
        img = imread(fullfile(directory, files(i).name));

        % imshow(img);
        
        % Calculate mean and standard deviation of pixel values
        mean_val = mean(img(:));
        std_val = std(double(img(:)));
        
        % Define the filename for saving .mat file
        save_filename = fullfile(dest, [filename, '.mat']);
        
        % Save the pixel_stats structure as a .mat file
        save(save_filename);
    end
    
    % Clear the workspace after each subdirectory iteration
    clearvars -except parent_directory subdirectories
end