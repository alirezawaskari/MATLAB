clear; clc;

% Specify the directory containing your feature .mat files
parent_directory = 'feature'; % Replace 'path_to_directory' with your directory path
subdirectories = {'NoFault', '3L', 'LL', 'L_G', 'LL_G'}; % Replace them with your subdirectories

% Initialize arrays to hold feature vectors and labels
all_feature_vectors = [];
all_labels = strings(0);

% Loop through each subdirectory
for subdir_idx = 1:numel(subdirectories)
    % Get the current subdirectory
    current_subdir = subdirectories{subdir_idx};
    
    % Define the directory path for subdirectories
    directory = fullfile(parent_directory, current_subdir);

    % List all .mat files in the current subdirectory
    files = dir(fullfile(directory, '*.mat'));
    
    % Loop through each data file
    for i = 1:numel(files)
        % Load the current feature file
        loaded_data = load(fullfile(directory, files(i).name)); % Load the .mat file
        feature_vector = loaded_data.feature_vector; % Assuming 'feature_vector' variable exists in the loaded file

        % Concatenate feature vectors into a single array
        all_feature_vectors = [all_feature_vectors; feature_vector];
        
        % Extract label information based on the filename
        [~, filename, ~] = fileparts(files(i).name); % Get the filename without extension
        parts = strsplit(filename, '_');
        label = strjoin(parts(2:end - 1), ' '); % Extract label information from the filename

        % Create corresponding labels for each feature vector set
        label = repmat(label, size(feature_vector, 1), 1); % Create labels based on the filename
        
        % Concatenate labels
        all_labels = [all_labels; label];
    end
end

% Save labels as a .mat file
filename = fullfile(parent_directory, 'labels.mat');
save(filename, 'all_labels', 'all_feature_vectors');