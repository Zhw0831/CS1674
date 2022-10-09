function [pyramid, level_0, level_1] = computeSPMRepr(im_size, sift, means);
% the image size [heigh width]
h = im_size(1);
w = im_size(2);

% the descriptors and their positions
d = sift.d;
f = sift.f;

% Part a
level_0 = computeBOWRepr(d', means);

% Part b
mid_h = h/2;
mid_w = w/2;

% divide the image into 4 quadrants and compute separately
qua_1 = [];
qua_2 = [];
qua_3 = [];
qua_4 = [];

for i=1:size(f,2)
    x = f(1,i);
    y = f(2,i);
    % quadrants
    % q1|q2
    % -----
    % q3|q4
    % if in quadrant 1
    if(x<mid_h && y<mid_w)
        qua_1 = [qua_1 d(:,i)];
    elseif(x<mid_h && y>mid_w)
        qua_2 = [qua_2 d(:,i)];
    elseif(x>mid_h && y<mid_w)
        qua_3 = [qua_3 d(:,i)];
    elseif(x>mid_h && y>mid_w)
        qua_4 = [qua_4 d(:,i)];
    end
end

% compute for each of the 4 quadrants
bow_1 = computeBOWRepr(qua_1',means);
bow_2 = computeBOWRepr(qua_2',means);
bow_3 = computeBOWRepr(qua_3',means);
bow_4 = computeBOWRepr(qua_4',means);

level_1 = cat(2,bow_1,bow_2,bow_3,bow_4);

% concatenate 2 levels
pyramid = cat(2,level_0,level_1);


