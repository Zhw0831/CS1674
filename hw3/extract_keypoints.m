function [x, y, scores, Ih, Iv] = extract_keypoints(image)
img = imread(image);

% Part a
k = 0.05;                               % set value k from the algorithm to be 0.05
h = 5;                                  % the window size
I = double(im2gray(img));             % convert the image to grayscale double

filter = [1 0 -1];    % gradient filter
Ih = imfilter(I, filter);             % apply the gradient filter
Iv = imfilter(I, filter');   

row_num = size(img,1);                    % number of rows in the image
col_num = size(img,2);                    % number of columns in the image

R = zeros(row_num, col_num);            % initialize R that stores the scores for each pixel

% Part b
n_range = ceil((h/2)-1);                % find the largest number that is less than half_window_size

for i = 1:row_num                       % loop through each pixel
    for j = 1:col_num
        M = zeros(2,2);                 % initialize the M matrix
        if i <= n_range || i > row_num-n_range || j <= n_range || j > col_num-n_range     % not enough neighbors, set their R values to -Inf
            R(i,j) = -Inf;
        else                                          % for pixels that have enough neighbors, we use the algroithm to compute R
            for x = i-n_range:i+n_range
                for y = j-n_range:j+n_range
                    M(1,1) = M(1,1) + Ih(x,y)^2;
                    M(1,2) = M(1,2) + Ih(x,y)*Iv(x,y);
                    M(2,1) = M(2,1) + Ih(x,y)*Iv(x,y);
                    M(2,2) = M(2,2) + Iv(x,y)^2;
                end
            end
            R(i,j) = det(M) - k*(trace(M)^2);      % compute R
        end
    end
end

% Part c
% set the threshold
threshold = abs(5*mean(R(R ~= -Inf)));      % set threshold to 5 times the average of the valid R values

% Part d
valid_xy = ones(row_num,col_num);           % a flag matrix tracking if each pixel is a valid key point

for i = 1:row_num                           % for each pixel, check if it's a valid key point
    for j = 1:col_num
        comp = R(i,j);
        if comp == -inf                     % kill the point if its R value is -Inf
            valid_xy(i,j) = 0;
        elseif comp <= threshold            % kill the point if its R value is less than threshold
            valid_xy(i,j) = 0;
        elseif i == 1 || i == row_num || j == 1 || j == col_num         % kill the point if it doesn't have 8 neighbors
            valid_xy(i,j) = 0;
        % kill the point if it is not larger than all of its 8 neighbors
        elseif comp <= R(i-1,j-1) || comp <= R(i-1,j) || comp <= R(i-1,j+1) || comp <= R(i,j-1) || comp <= R(i,j+1) || comp <= R(i+1,j-1) || comp <= R(i+1,j) || comp <= R(i+1,j+1)
            valid_xy(i,j) = 0;
        end
    end
end

scores = [];
x = [];
y = [];
counter = 1;                                    % tracks the position of next value in scores, x, and y

for i = 1:row_num
    for j = 1:col_num
        if valid_xy(i,j) == 1                   % if the point passed the validation tests in the previous part, its valid_xy value is 1
            scores(counter,1) = R(i,j);         % add the R score of the key point to the scores vector
            x(counter,1) = i;                   % add the x coord of the key point to the scores vector
            y(counter,1) = j;                   % add the y coord of the key point to the scores vector
            counter = counter + 1;              % increment the counter
        end
    end
end

% Part e
figure;
imshow(img);
hold on;

for i = 1:length(x)
    plot(y(i), x(i), 'bo', 'MarkerSize', scores(i)/1000000000);     % plot the key points, scaled by their scores
end

    
 