fprintf('Number of files in Validation-set: %d\n', numel(datacode.valid_img_names));
fprintf('Number of labels in Validation-set: %d\n', numel(datacode.valid_labels));

% Define TensorFlow placeholders
x = tf('single', 'size', [NaN, size_image, size_image, num_channels], 'name', 'x');
y_true = tf.placeholder(tf.float32, [NaN, numel(classes)], 'name', 'y_true');

% Network graph parameters
filter_size_conv1 = 3;
num_filters_conv1 = 32;
filter_size_conv2 = 3;
num_filters_conv2 = 32;
filter_size_conv3 = 3;
num_filters_conv3 = 64;
fc_layer_size = 128;

% Define weights and biases creation functions
create_weights = @(shape) tf.Variable(tf.truncated_normal(shape, 'stddev', 0.05));
create_biases = @(size) tf.Variable(tf.constant(0.05, 'shape', [size]));

% Create convolutional layers
layer_conv1 = create_convolutional_layer(x, num_channels, filter_size_conv1, num_filters_conv1);
layer_conv2 = create_convolutional_layer(layer_conv1, num_filters_conv1, filter_size_conv2, num_filters_conv2);
layer_conv3 = create_convolutional_layer(layer_conv2, num_filters_conv2, filter_size_conv3, num_filters_conv3);

% Create flatten layer
layer_flat = create_flatten_layer(layer_conv3);

% Create fully connected layers
layer_fc1 = create_fc_layer(layer_flat, numel(layer_flat), fc_layer_size, true);
layer_fc2 = create_fc_layer(layer_fc1, fc_layer_size, numel(classes), false);

% Define predictions and accuracy
y_pred = tf.nn.softmax(layer_fc2, 'name', 'y_pred');
y_pred_cls = tf.argmax(y_pred, 1, 'name', 'y_pred_cls');

% Define optimization
cross_entropy = tf.nn.softmax_cross_entropy_with_logits(layer_fc2, y_true);
cost = tf.reduce_mean(cross_entropy);
optimizer = tf.train.AdamOptimizer(1e-4).minimize(cost);

correct_prediction = tf.equal(y_pred_cls, tf.argmax(y_true, 1));
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32));

% Initialize variables
session = tf.Session();
session.run(tf.global_variables_initializer());

% Train the model
total_iterations = 0;

for i = 1:3000
    x_valid_batch = datacode.valid.images(:, :, :, (i-1)*batch_size + 1:i*batch_size);
    y_valid_batch = datacode.valid.labels((i-1)*batch_size + 1:i*batch_size, :);

    feed_dict_val = {x, x_valid_batch, y_true, y_valid_batch};

    session.run(optimizer, feed_dict_val);

    if mod(i, floor(size(datacode.valid.images, 4)/batch_size)) == 0
        val_loss = session.run(cost, feed_dict_val);
        epoch = floor(i / floor(size(datacode.valid.images, 4)/batch_size));

        val_acc = session.run(accuracy, feed_dict_val);

        fprintf('Validation Epoch %d --- Validation Accuracy: %6.1f%%, Validation Loss: %.3f\n', epoch, val_acc * 100, val_loss);
    end
end

% Save the model
saver = tf.train.Saver();
saver.save(session, '');