function [B] = normalize_columns(A)

% my thinking process and algorithm: 

% 1. calculate the sum of each column generate a row vector out of that;

% 2. get the size of a single column in A (treat each column as a column vector and
% get the row x column size);

% 3. repeat the sum vector in step 1 to produce a matrix of the same size
% as A;

% 4. element-wise divide A by the matrix values in step 3.

B = A./(repmat(sum(A,1),size(A(:,1))));

end