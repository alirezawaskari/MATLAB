clear % Recomended for mistake prevention
clc % Clear output window

% Specify the directory containing your feature .mat files
parent_directory = 'path_to_directory'; % Replace 'path_to_directory' with your directory path
subdirectories = {'sub1', 'sub2', 'sub3', 'sub3', ...}; % Replace them with your subdirectories

% Loop through each subdirectory
for subdir_idx = 1:numel(subdirectories)
    % Get the current subdirectory
    current_subdir = subdirectories{subdir_idx};
    
    % Define the directory path for the current subdirectory
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

        % Replace this with your plot %

        % Extract the filename without extension
        [~, filename, ~] = fileparts(files(i).name); % Extract filename without extension
    
        % % Set high resolution for the plot
        set(gcf,'renderer','Painters'); % Set renderer for better vector graphics
        set(gcf,'color','w'); % Set background color
        set(gca, 'FontSize', 12); % Set font size for better readability
        
        % % Save the plot as an image with high resolution
        print(fullfile(dest, [filename, '.png']), '-dpng', '-r1500'); % Save as PNG
        close all
    end

    % Clear the workspace after each subdirectory iteration
    clearvars -except parent_directory subdirectories
end