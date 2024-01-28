% run
clc
clear

size_image = 64;
validation_size = 0.4;
num_channels = 3; % for R G B
batch_size = 32;
images = [];
target_class = [];

% Load datacode
classes = {"LL","3L","LL_G","L_G"};
path = 'mainWorkspace/Generator/plots/';

% Load data and create datasets
datacode = read_train_sets(path, size_image, classes, validation_size);
data_sets = read_train_sets(path, size_image, classes, validation_size);

% Training
TrainingData;

% Testing
TestModel;