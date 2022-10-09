function H = estimate_homography(PA, PB)

A = [];                 % initialize matrix A

for i=1:size(PA,1)      % for each of the number of point pairs
    x = PA(i,1);        % x coord in PA
    y = PA(i,2);        % y coord in PA
    x_tr = PB(i,1);     % x coord in PB
    y_tr = PB(i,2);     % y coord in PB
    
    A_sub = [-x -y -1 0 0 0 x*x_tr y*x_tr x_tr;
             0 0 0 -x -y -1 x*y_tr y*y_tr y_tr];       % set the A matrix for the specific pair
         
    A = [A;A_sub];                  % append the newly calculated A matrix to the big A matrix
end

[~, ~, V] = svd(A); 
h = V(:, end); 
H = reshape(h, 3, 3)';