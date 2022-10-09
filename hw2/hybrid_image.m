% Part II

% Problem 2 - image processing before filtering
% read in both images, convert to grayscale, and resize to 512 x 512
im1 = imread('woman_happy.png');
im1 = rgb2gray(im1);
im1 = imresize(im1,[512 512]);

im2 = imread('woman_neutral.png');
im2 = rgb2gray(im2);
im2 = imresize(im2,[512 512]);

% Problem 3 - apply gaussian filter on both images
im1_blur = imgaussfilt(im1, 10, 'FilterSize', 31);
im2_blur = imgaussfilt(im2, 10, 'FilterSize', 31);

% Problem 4 - obtain the detailed image
im2_detail = im2 - im2_blur;

% Problem 5 - hybrid, show, and save
I = im1_blur + im2_detail;
imshow(I);
saveas(gcf,'hybrid.png');

