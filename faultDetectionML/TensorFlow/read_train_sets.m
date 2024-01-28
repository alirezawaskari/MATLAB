function data_set = read_train_sets(path, size_image, classes, validation_size)
    % Load data
    [images, labels, img_names, cls] = load_train(path, size_image, classes);

    % Shuffle data
    idx = randperm(size(images, 4));
    images = images(:, :, :, idx);
    labels = labels(idx, :);
    img_names = img_names(idx);
    cls = cls(idx);

    % Calculate validation size
    if isfloat(validation_size) && validation_size > 0 && validation_size < 1
        validation_size = round(validation_size * size(images, 4));
    elseif validation_size >= size(images, 4)
        error('Validation size exceeds the number of available images.');
    end

    % Split into training and validation sets
    validation_images = images(:, :, :, 1:validation_size);
    validation_labels = labels(1:validation_size, :);
    validation_img_names = img_names(1:validation_size);
    validation_cls = cls(1:validation_size);

    train_images = images(:, :, :, validation_size+1:end);
    train_labels = labels(validation_size+1:end, :);
    train_img_names = img_names(validation_size+1:end);
    train_cls = cls(validation_size+1:end);

    % Create DataSet object
    data_set.train_images = train_images;
    data_set.train_labels = train_labels;
    data_set.train_img_names = train_img_names;
    data_set.train_cls = train_cls;

    data_set.valid_images = validation_images;
    data_set.valid_labels = validation_labels;
    data_set.valid_img_names = validation_img_names;
    data_set.valid_cls = validation_cls;
end