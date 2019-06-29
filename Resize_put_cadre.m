function im_new_padded = Resize_put_cadre(im, image_size_2d )
%% 1. Resize image down to image_size w/ ratio if image size >100
height = size(im,1);
width = size(im,2);
image_size = image_size_2d(1); %[100 100]
if(height > image_size || width > image_size) %if either height or width >100 -> resize to a proportional 100
    if(height >= width)
        im = imresize(im, [image_size NaN]);
    else % height < width
        im = imresize(im, [NaN image_size]);
    end
    %imshow(im);
end


%% 2. Binarization: Convert gray images to binary images using Otsu's method
%d = double(im)/255;
%im = rgb2gray(d);
level = graythresh(im);
im = im2bw(im,level);
im = 1 - im;
% figure;
% subplot(1,3,1)
% imshow(im);

%% 3. Smoothing: gaussian filtering
%im = imgaussfilt(im, 0.4);
% subplot(1,3,2);
% imshow(im);

%% 4. thinning
%im = thinning(im);
% subplot(1,3,3);
% imshow(im);


%% 4. shift image horizontally and vertically to middle
W = size(im,2); %i.e size of width of resized image (ex: 100)
RSW = floor((image_size-W)/2);% for image in middle

H = size(im,1); %i.e size of resized image (ex: 100)
RSH = floor((image_size-H)/2);% for image in middle

im_new_padded = zeros(image_size,image_size,size(im,3)); 
im_new_padded(RSH+1:(RSH+H),RSW+1:(RSW+W),:) = im;
end

