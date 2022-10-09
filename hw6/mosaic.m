% a. load the images and show them in separate figures. add impixelinfo

% load the images
%I1 = imread('keble1.png');
%I2 = imread('keble2.png');
I1 = imread('uttower1.jpg');
I2 = imread('uttower2.jpg');

% display and pixel info
figure(1);
imshow(I1);
impixelinfo;

figure(2);
imshow(I2);
impixelinfo;


% b. pick the distinctive points manually
% PA contains x y coordinates from image1 and PB from image2
%PA = [163 76; 162 146; 322 97; 337 13];
%PB = [67 88; 62 157; 227 112; 241 32];
PA = [412 310; 308 494; 528 333; 442 558; 102 503; 321 299];
PB = [857 336; 763 527; 983 352; 906 590; 566 541; 769 335];

% c. compute the homography
H = estimate_homography(PA,PB);

% d. pick a new point and show it in two images (one original, one computed)
%p1 = [278;123];
p1 = [104;613];
p2 = apply_homography(p1,H);        % apply the homography we calculated

% plot
figure(3);

subplot(1,2,1);
imshow(I1);
hold on;
plot(p1(1),p1(2),'gx','MarkerSize',5);
%title('point in keble1');
title('point in uttower1');
hold off;

subplot(1,2,2);
imshow(I2);
hold on;
plot(p2(1),p2(2),'yx','MarkerSize',5);
%title('point in keble2');
title('point in uttower2');
hold off;

% e. stitch two images
% create a canvas and center image2
row = size(I2,1);
col = size(I2,2);

canvas = zeros(3*row,3*col,3);

dI2 = im2double(I2);
dI1 = im2double(I1);

% center image2 in the middle by copying its pixel values to corresponding
% places on canvas
canvas(row+1:2*row,col+1:2*col,1:3) = dI2(1:row, 1:col, 1:3);

% compute new locations for every point in image1
for i = 1:size(I1,1)
    for j = 1:size(I1,2)
        p_1 = [j;i];
        p_2 = apply_homography(p_1,H);
        
        % get the 4 neighbors for later use
        % including the case where the point falls into the black part, we
        % need to add values to x,y to convert it to the canvas system
        x = p_2(1);
        y = p_2(2);
        n_lt = [col+floor(x),row+floor(y)];
        n_lb = [col+ceil(x),row+floor(y)];
        n_rt = [col+floor(x),row+ceil(y)];
        n_rb = [col+ceil(x),row+ceil(y)];
        
        % copy the image1 pixels to the 4 neighbors
        canvas(n_lt(2),n_lt(1),1:3) = dI1(i,j,1:3);
        canvas(n_lb(2),n_lb(1),1:3) = dI1(i,j,1:3);
        canvas(n_rt(2),n_rt(1),1:3) = dI1(i,j,1:3);
        canvas(n_rb(2),n_rb(1),1:3) = dI1(i,j,1:3);
    end
end

% show the stitched result
figure(4);
imshow(canvas);
          



