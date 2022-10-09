function [centers] = detectCircles(im, edges, radius, top_k)

I = imread(im);

x = edges(:,1);                 % the x coordinates of the edge points
y = edges(:,2);                 % the y coordinates of the edge points
oria = edges(:,4);

H = zeros(length(x));           % initialize the hough votes matrix
quantization_value = 5;         % for bins in hough space

for i = 1:length(x)
    x_coord = x(i);
    y_coord = y(i);
    theta = oria(i);
    
    a = x_coord - radius * cosd(theta);     % calculate column
    b = y_coord - radius * sind(theta);     % calculate row
    
    a = abs(ceil(a/quantization_value))+1;
    b = abs(ceil(b/quantization_value))+1;
    
    H(a,b) = H(a,b) + 1;           % increase votes for the point
end

[rank,indices] = sort(H(:),'descend');      % sort the votes matrix
ind = indices(1:top_k);                     % find the indices of top k votes

[row,col] = ind2sub(size(H),ind);           % get the coord values (after quantization) of the k points

centers = zeros(top_k,2);

rem = [];

for i = 1:top_k
    centers(i,1) = row(i)*quantization_value;       % multiply the quantization value to go back to the original x y
    centers(i,2) = col(i)*quantization_value;
    
    if centers(i,1) > size(I,1) || centers(i,2) > size(I,2)       % if the center is outside of the image, ignore it
        rem = [rem, i];
    end
end

centers(rem(:),:) = [];


figure;
imshow(I);
viscircles(centers, radius * ones(size(centers, 1), 1));

header = sprintf('Detect with radius %d', radius);
title(header);

    