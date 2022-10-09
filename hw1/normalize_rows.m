function [B] = normalize_rows(A)

% my thinking process and algorithm: 

% 1. calculate the sum of each row generate a column vector out of that;

% 2. get the size of a single row in A (treat each row as a row vector and
% get the row x column size);

% 3. repeat the sum vector in step 1 to produce a matrix of the same size
% as A;

% 4. element-wise divide A by the matrix values in step 3.

B = A./(repmat(sum(A,2),size(A(1,:))));

end