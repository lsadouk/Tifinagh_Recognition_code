function im_r = resizing_with_binarization(im, image_size)

% read the image
%image_size = [64 64];
%im = imread('1.png');
%figure, imshow(im);

% resize the image (bicubic)
im_r = imresize(im, image_size, 'bicubic');
%figure, imshow(im_r);

% binarize the image with given threshold
% % threshold = 0.95;
% % im_b = im2bw(im_r, threshold); % level = threshold
% % im_b = im_b *255;
%figure, imshow(im_b);






%im_n = imresize(im, [64 64]);
%figure, imshow(im_n);