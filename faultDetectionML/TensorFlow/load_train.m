function [images, labels, img_names, cls] = load_train(path, size_image, classes)
    images = [];
    labels = [];
    img_names = {};
    cls = {};

    disp('Going to read training images');

    for class_idx = 1:numel(classes)
        current_class = classes{class_idx};
        disp(['Now going to read ', current_class, ' files (Index: ', num2str(class_idx), ')']);

        current_path = fullfile(path, current_class, '*.png');
        files = dir(current_path);

        for file_idx = 1:numel(files)
            file = files(file_idx);
            file_path = fullfile(file.folder, file.name);

            % Read image using imread (equivalent to PIL.Image.open in Python)
            im = imread(file_path);

            % Resize image (equivalent to scipy.misc.imresize)
            im = imresize(im, [size_image, size_image]);

            % Convert to 3D image (equivalent to np.atleast_3d)
            im = im(:,:,[1,1,1]);

            images = cat(4, images, im);

            % Create label vector
            lbl = zeros(1, numel(classes));
            lbl(class_idx) = 1.0;
            labels = [labels; lbl];

            % Extract file base name
            [~, file_base, ~] = fileparts(file.name);
            img_names = [img_names; file_base];

            % Store class
            cls = [cls; current_class];
        end
    end

    % Convert to MATLAB array
    images = permute(images, [1, 2, 4, 3]);
    labels = double(labels);
    img_names = cellstr(img_names);
    cls = cellstr(cls);
end