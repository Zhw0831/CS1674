function [energyImage, Ix, Iy] = energy_image(im)

    I = double(rgb2gray(im));               % convert input image to grayscale and double data type

    filter_x = [1 0 -1; 2 0 -2; 1 0 -1];    % gradient filter in class on x direction
    Ix = imfilter(I, filter_x);             % apply the gradient filter
    
    filter_y = (filter_x)';                 % same gradient filter but on y direction
    Iy = imfilter(I, filter_y);             % apply the gradient filter
    
    energyImage = sqrt((Ix).^2+(Iy).^2);    % compute energy image

