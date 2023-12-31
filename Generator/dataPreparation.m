clear; clc;

% Define directories
directories = {'NoFault', '3L', 'LL', 'L_G', 'LL_G'};
fault_types = {'None', '3L', 'LL', 'LG', 'LLG'};

% Loop through each directory
for dir_idx = 1:numel(directories)
    current_dir = directories{dir_idx};
    fault_type = fault_types{dir_idx};

    % Define the destination path for subdirectories
    dest = fullfile('feature', current_dir); % Replace 'destination' with your subdirectories

    % Create a destination directory if it doesn't exist
    if ~exist(dest, 'dir')
        mkdir(dest);
    end

    % Load data from imgProc.mat
    load(fullfile('imProc', current_dir, ['output_a_', fault_type, '_fault_bus0.mat']));

    % Load data from colorProc.mat
    load(fullfile('colorProc', current_dir, ['output_a_', fault_type, '_fault_bus0_colors.mat']));

    % Load data from grayEdge.mat
    load(fullfile('grayEdge', current_dir, ['output_a_', fault_type, '_fault_bus0_edges.mat']));

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

    disp(feature_vector)

    % Save feature_vector as a .mat file
    for bus_num = 0:6
        save_filename = fullfile('feature', current_dir, ['output_a_', fault_type, '_fault_bus', num2str(bus_num), '_feature.mat']);
        save(save_filename, 'feature_vector');
    end
    % Clear the workspace after each subdirectory iteration
    clearvars -except directories fault_types
end