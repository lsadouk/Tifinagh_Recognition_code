function gry = rotating(im)

%im = imread('data/32tifinaghData/a/0.png');
%size = size(im);
%im = 255 -im;
%im = cat(3, i, i, i);  

%generate a random number in range from (10 to 90 degrees)
xmin=-20;  % WAS -25
xmax=20;  % WAS 25
x = xmin+rand(1,1)*(xmax-xmin);

% rotate by x degrees
gry = imrotate(im, floor(x),'bilinear','crop'); 
%mgry = ~imrotate(true(size(im)),floor(x),'bilinear','crop'); 
%gry(mgry&~imclearborder(mgry)) = 255;
%imshow(gry);

