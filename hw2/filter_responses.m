% Part I

F = makeLMfilters;

% Problem 3 - filter the images

filenames = {'cardinal1.jpg','cardinal2.jpg','leopard1.jpg','leopard2.jpg','panda1.jpg','panda2.jpg'};  % the cell array of filenames
results = cell(6,48);                   % store the results of filtering in a cell array for 6 images and 48 filters

for i  = 1: length(filenames)           % loop through the filename array    
    I = imread(filenames{i});           % read in the image
    I2 = rgb2gray(I);                   % convert it to grayscale
    I3 = imresize(I2, [100 100]);       % resize it to 100x100 so all images have the same square size
    for j = 1:48                        % loop through each filter
        I4 = imfilter(I3, F(:,:,j),'corr');    % filter the image
        results{i,j} = I4;              % store the filtered image in the cell array    
    end
end


% Problem 4 - create the subplots
for i = 1:48                                                              % loop through all 48 filters
    subplot(2,4,1),imagesc(F(:,:,i));                                      % plot the filter at position (1,1)
                                                                          % (1,2) is intentionally left blank
    for j = 3:8                                                           % starting from (1,3),plot the filtered images
        subplot(2,4,j),imagesc(results{j-2,i}), title(filenames{j-2});      % j-2 because we start plotting the filtered images at position (1,3)
    end
    saveas(gcf,strcat('responses_to_filter_',num2str(i),'.png'));         % save the images for later use
end

    

        