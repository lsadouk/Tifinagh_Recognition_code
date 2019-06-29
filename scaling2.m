function im_new_padded = scaling2(I)
%I=imread('code_deeper_dropout/2.png');
%I= imresize(I,[224 224]);
%I = 255 -I;
%figure, imshow(I);

%% 1. generate a random number (scaling factor) in range from (0.4 to 0.8)
xmin=0.7; %0.5
xmax=1; %1
x = xmin+rand(1,1)*(xmax-xmin);
y = xmin+rand(1,1)*(xmax-xmin);

%% 2. resize the image with that random scaling number
im_new = imresize(I, [x*size(I,1), y*size(I,2)], 'nearest');

%% 3. shift image horizontally
W = size(im_new,2); %i.e size of width of resized image (ex: 100)
RSW = floor((size(I,2)-W)) +1;%i.e 225-WH+32 ==> for image in middle

%% 4. shift image vertically
H = size(im_new,1); %i.e size of resized image (ex: 100)
% RSH = floor((size(I,1)-H)) +1 ;%i.e 225-WH+32 ==> for image in middle

%% 5. apply transformations
x = randperm(RSW,1);
%y = randperm(RSH,1);

im_new_padded = zeros(size(I,1),size(I,2),size(I,3)); 
im_new_padded(1:H ,x:(x+W-1),:) = im_new;

%figure, imshow(im_new_padded,[]);


%im_nedffxw_padded = im_new(x:(x+WH-1),y:(y+WH-1),:);
