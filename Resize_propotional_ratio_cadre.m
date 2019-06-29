% im = imread('data/32tifinaghData/hh/yahh_script_1_7.png'); 
im = imread('data/32tifinaghData/aa/yae_script_31_9.png'); 
% aa yae_script_31_9 "size:136*145"  --> goal: 93*100
% aa yae_script_60_13 "size:63*55"
% hh yahh_script_1_7 "size:115*53"

%% 1. Resize image down to 100 w/ ratio if image size >100
height = size(im,1);
width = size(im,2);
image_size = 100; %[100 100]
if(height > 100 || width > 100) %if either height or width >100 -> resize to a proportional 100
    if(height >= width)
        im = imresize(im, [100 NaN]);
    else % height < width
        im = imresize(im, [NaN 100]);
    end
    %imshow(im);
end


%% 2. Binarization: Convert gray images to binary images using Otsu's method
% d = double(im)/255;
%im = rgb2gray(d);
level = graythresh(im);
im = im2bw(im,level);
im = 1 - im;
%im = double(not(im2bw(im,level))); % not = im = 1 - im; % change color from black to white
%imshow(im);
figure;
subplot(1,3,1)
imshow(im);

% %% 1. Resize image down to 100 w/ ratio if image size >100
% height = size(im,1);
% width = size(im,2);
% image_size = 100; %[100 100]
% if(height > 100 || width > 100) %if either height or width >100 -> resize to a proportional 100
%     if(height >= width)
%         im = imresize(im, [100 NaN],'nearest');
%     else % height < width
%         im = imresize(im, [NaN 100],'nearest');
%     end
%     %imshow(im);
% end

%% 3. Smoothing: gaussian filtering
%im = imgaussfilt(im, 0.3);
subplot(1,3,2);
imshow(im);

%% 3. thinning
im = thinning(im);
subplot(1,3,3);
imshow(im);


%% 4. shift image horizontally and vertically to middle
W = size(im,2); %i.e size of width of resized image (ex: 100)
RSW = floor((image_size-W)/2);% for image in middle

H = size(im,1); %i.e size of resized image (ex: 100)
RSH = floor((image_size-H)/2);% for image in middle

im_new_padded = zeros(image_size,image_size,size(im,3)); 
im_new_padded(RSH+1:(RSH+H),RSW+1:(RSW+W),:) = im;
%imshow(im_new_padded);

%% extra methods for thining
%im = bwmorph(im,'skel',Inf);%bad one coz has noise&discontinuity in image
%im = bwmorph(im,'thin',Inf);
%im = bwmorph(im,'clean');
%im = bwmorph(im,'thin');
