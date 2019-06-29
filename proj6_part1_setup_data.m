function imdb = proj6_part1_setup_data()
%code for Computer Vision, Georgia Tech by James Hays

%This path is assumed to contain 'test' and 'train' which each contain 15
%subdirectories. The train folder has 100 samples of each category and the
%test has an arbitrary amount of each category. This is the exact data and
%train/test split used in Project 4.
SceneJPGsPath = 'data/32tifinaghData/';

num_train_per_category = 30; % 520 = 2/3 of 780 are training images per category
num_test_per_category  = 20; % 260 = 1/3 of 780 are testing images per category
total_images = 31*num_train_per_category + 31 * num_test_per_category; %32 classes

image_size = [60 60]; %downsampling + uniformising data 


imdb.images.data   = zeros(image_size(1), image_size(2), 1, total_images, 'single');
imdb.images.labels = zeros(1, total_images, 'single');
imdb.images.set    = zeros(1, total_images, 'uint8');
image_counter = 1;

categories = {'a',	'aa',	'b',	'ch',	'd',...
     'dd',	'e',	'f',	'g',	'gh',	'h',	'hh',...
     'i',	'j',	'k',	'kh',	'l',...
     'm',	'n',	'q',	'r',	'rr',	's',	'ss',...
     't',	'tt',	'u',	'w',	 ...
     'y',	'z',	'zz'};
          
sets = {'train', 'test'};

fprintf('Loading %d train and %d test images from each category\n', ...
          num_train_per_category, num_test_per_category)
fprintf('Each image will be resized to %d by %d\n', image_size(1),image_size(2));

%threshold = 0.88;
for set = 1:length(sets)
    for category = 1:length(categories)
        cur_path = fullfile( SceneJPGsPath,  categories{category});
        cur_images = dir( fullfile( cur_path,  '*.png') );
        
        if(set == 1)
            fprintf('Taking %d out of %d images in %s\n', num_train_per_category, length(cur_images), cur_path);
            cur_images = cur_images(1:num_train_per_category); % go from image 1 to 40
        elseif(set == 2)
            fprintf('Taking %d out of %d images in %s\n', num_test_per_category, length(cur_images), cur_path);
            cur_images = cur_images(num_train_per_category+1:num_train_per_category+num_test_per_category); % go from image 41 to 80
        end

        for i = 1:length(cur_images)
            cur_image = imread(fullfile(cur_path, cur_images(i).name));
            cur_image  = Resize_put_cadre(cur_image, image_size );
            % imshow(cur_image);
            cur_image  = cur_image *255;
            % Stack images into a large 64 x 64 x 1 x total_images matrix
            % images.data
            imdb.images.data(:,:,1,image_counter) = cur_image;            
            imdb.images.labels(  1,image_counter) = category;
            imdb.images.set(     1,image_counter) = set; %1 for train, 2 for test (val?)
            
            image_counter = image_counter + 1;
        end
    end
end


%%  Zero centering images METHOD1 : substract the mean image of all images from each image
% % calculate the mean from the array
% mean_img = mean(imdb.images.data,4);
% % subtract the mean image from all the images in array
% imdb.images.data = imdb.images.data - repmat(mean_img,[1 1 1 size(imdb.images.data,4)]);
% % % another method
% % for i = 1:size(imdb.images.data,4)
% %     imdb.images.data(:,:,:,i) = imdb.images.data(:,:,:,i) - mean_img;
% % end

