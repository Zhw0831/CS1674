function [features] = compute_features(x, y, scores, Ix, Iy)

row_num = size(Ix,1);           % get the number of rows in the image
col_num = size(Ix,2);           % get the number of columns in the image

% Problem 1: remove key points if it doesn't have 5 neighbors in
% top/bottom/left/right directions
remove = [];                % store the indices for x,y coordinates to remove
for i = 1:length(x)
    x_coord = x(i);
    y_coord = y(i);
    if x_coord <= 5 || x_coord > col_num - 5 || y_coord <= 5 || y_coord > row_num - 5   % if the pixel doesn't have enough neighbors
        remove = [remove; i];
    end
end

x(remove(:)) = [];          % remove its x,y coordinates and scores from the x,y,scores vectors
y(remove(:)) = [];

features = zeros(length(x),8);  % initialize the features vector after excluding key points with not enough neighbors

% Problem 2: calculate the gradient magnitude and angle
m = zeros(11,11);             % initialize the maginitude matrix
theta = zeros(11,11);         % initialize the theta matrix

for i = 1:length(x)                      % for each key point
    x_coord = x(i);
    y_coord = y(i);
    for j = x_coord-5:x_coord+5             % for each of its neighbors
        for k = y_coord-5:y_coord+5
            m(j,k) = sqrt(Ix(j,k)^2 + Iy(j,k)^2);       % compute the gradient magnitude
            if m(j,k) ~= 0
                theta(j,k) = atand(Iy(j,k)/Ix(j,k));    % compute the gradient angle
            end
        end
    end


% Problem 3: quantize the gradients into 8 bins
    bin_num = zeros(11,11);
    x_coord = x(i);
    y_coord = y(i);
    for j = x_coord-5:x_coord+5
        for k = y_coord-5:y_coord+5
            angle = theta(j,k);
            if angle >= -90 && angle < -67.5
                bin_num(j,k) = 1;
            elseif angle >= -67.5 && angle < -45
                bin_num(j,k) = 2;
            elseif angle >= -45 && angle < - 22.5
                bin_num(j,k) = 3;
            elseif angle >= -22.5 && angle < 0
                bin_num(j,k) = 4;
            elseif angle >= 0 && angle < 22.5
                bin_num(j,k) = 5;
            elseif angle >= 22.5 && angle < 45
                bin_num(j,k) = 6;
            elseif angle >= 45 && angle < 67.5
                bin_num(j,k) = 7;
            elseif angle >= 67.5 && angle <= 90
                bin_num(j,k) = 8;
            end
        end
    end
    

% Problem 4: populate the SIFT histogram
hist_final = zeros(1,8);
for j = 1:8
    ind = find(bin_num == j);
    hist_final(j) = sum(m(ind));            % sum up all the gradients of the pixels that fall into the bin
end


% Problem 5: clip and normalize
hist_final = hist_final / sum(hist_final);      % normalize before clip
for j = 1:length(hist_final)
    if hist_final(j) > 0.2
        hist_final(j) = 0.2;            % clip the values to 0.2
    end
end
hist_final = hist_final / sum(hist_final);      % normalize after clip
             
features(i,:) = hist_final;

end
    
       


