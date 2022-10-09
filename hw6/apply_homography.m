function [p2] = apply_homography(p1, H)

p1 = [p1;1];                % set the p1 to [x;y;1]
p = H*p1;                   % apply the matrix multiplication
w = p(3);                   % get the w
p2 = [p(1)/w; p(2)/w];      % divide wx, wy by w to convert to the image coordinates