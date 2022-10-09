function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k);

I = imread(origImg);                        % read in the image
I2 = I;

meanColors = zeros(k,3);

numrows = size(I,1);
numcols = size(I,2);
numpixels = numrows*numcols;                % calculate the number of pixels based on the number of rows and cols

X = reshape(I, [numpixels, 3]);             % reshape to a matrix with RGB features as rows
clusterIds = kmeans(double(X), k);          % apply kmeans to cluster

for i = 1:k                                 % for each cluster
    count = 0;                              % for cluster size
    sumR = 0;
    sumG = 0;
    sumB = 0;
    
    ind = find(clusterIds==i);              % find the indices where the pixel belongs to the cluster
    
    for q = 1:length(ind)
        j = ind(q);
        [x,y] = ind2sub([numrows numcols],j);       % get the x,y coordinates in the original image
        count = count + 1;                          % increment count for the cluster size
        sumR = sumR + double(I(x,y,1));             % add the pixel value in the original image to the sum
        sumG = sumG + double(I(x,y,2));
        sumB = sumB + double(I(x,y,3));
    end
    
    aveR = sumR/count;                  % calculate the average pixel values for all 3 channels
    aveG = sumG/count;
    aveB = sumB/count;
    
    meanColors(i,1) = aveR;
    meanColors(i,2) = aveG;
    meanColors(i,3) = aveB;
    
    for q = 1:length(ind)
        j = ind(q);
        [x,y] = ind2sub([numrows numcols],j);
        I2(x,y,1) = aveR;                              % replace the pixel values in the new image with the 
        I2(x,y,2) = aveG;                              % average value of the cluster it belongs to
        I2(x,y,3) = aveB;
    end
end

outputImg = I2;

figure;                                                 % plot the images
subplot(1,2,1), imshow(I), title('original image');
t = strcat('quantized image for k=',num2str(k));
subplot(1,2,2), imshow(outputImg), title(t);
        


