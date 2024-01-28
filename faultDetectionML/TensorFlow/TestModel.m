for classIndex = 1:numel(classes)
    className = classes{classIndex};
    fprintf('Now going to read %s files (Index: %d)\n', className, classIndex);
    
    classPath = fullfile(path, className, '*.jpg');
    files = dir(classPath);

    for fileIndex = 1:numel(files)
        filePath = fullfile(files(fileIndex).folder, files(fileIndex).name);
        im = imread(filePath);
        im = imresize(im, [size_image, size_image]);
        im = im2single(im);
        images = cat(4, images, im);
        target_class = [target_class; classIndex];
    end
end

fprintf('Number of files in Testing-set: %d\n', size(images, 4));

% The input to the network is of shape [None image_size image_size num_channels]. Hence we reshape.
% x_batch = images.reshape(-1, size_image,size_image,num_channels);
x_batch = images;

%% Let us restore the saved model
session = tf.Session();
% Step-1: Recreate the network graph. At this step only graph is created.
saver = tf.train.import_meta_graph('mstar-model.meta');
% Step-2: Now let's load the weights saved using the restore method.
saver.restore(session, tf.train.latest_checkpoint('./'));

% Accessing the default graph which we have restored
graph = tf.get_default_graph();
% Now, let's get hold of the op that we can be processed to get the output.
% In the original network y_pred is the tensor that is the prediction of the network
y_pred = graph.get_tensor_by_name('y_pred:0');

% Let's feed the images to the input placeholders
x = graph.get_tensor_by_name('x:0');
y_true = graph.get_tensor_by_name('y_true:0');
y_test_images = zeros(1, numel(classes));

% Creating the feed_dict that is required to be fed to calculate y_pred
feed_dict_testing = {x, x_batch, y_true, y_test_images};
result = session.run(y_pred, feed_dict_testing);
[~, tgt_class] = max(result, [], 2);

target_class = target_class';
fprintf('Target Class Indices: %s\n', mat2str(target_class));

writematrix(target_class, 'ClassesIndices.csv');
writematrix(result, 'Results.csv');
writematrix(target_class, 'TargetClassNames.csv');
