clc

fprintf('Part 1: Matrices and vectors\n')
% 
% 1. Generate a 1000000x1 (one million by one) vector of random numbers from a Gaussian (normal) 
% distribution with mean of 0 and standard deviation of 5. Use Matlab's randn function.

mean = 0; std = 5; r = 1000000;      % specify the variable values of mean, standard deviation, and number of rows
v = std.*randn(r,1) + mean;                  % generate the vector with specific size, mean, and standard deviation from a normal distribution

% 2. Add 1 to every value in the previous list, by using a loop. To determine how many times to loop, 
% use Matlab's size function. Time this operation and print the number in the code. 

v_loop = v;                         % get a copy of the vector in question #1 for later edit use

need_loop = size(v_loop,1)          % get the number of rows, i.e. how many times we need to loop

tic
for i = 1:need_loop 
    v_loop(i,:) = v_loop(i,:) + 1;  % add 1 to every row
end
time_elapsed_loop = toc             % time of the operation



% 3. Now add 1 to every value in the original random vector, without using a loop. 
% Time this operation, print the time and write it down.

tic
v = v + ones(r,1);               % add 1 by matrix operation
time_elapsed_no_loop = toc;      % time of the operation

fprintf('time_elapsed_no_loop = \n\n')    
disp(time_elapsed_no_loop)        % print out the time using disp()



% 4. Plot the exponential function 2.^x, for non-negative even values of x smaller than 100, without using loops.

x = 0:2:98;                      % generate an x containing even values ranging from 0 to 98
plot(x,2.^x)

% 5. Create two matrices A and B which, when added together, result in a 10x10 matrix C containing all numbers from 1 to 100. 
% In other words, when I add A and B and convert the result to vector form, I should get a vector containing all numbers from 1 to 100. 
% In code, C = A + B; assert(all(C(:) == (1:100)') == 1); Each matrix should only be created with a single command (no loops).

A = [1 2 3 4 5 6 7 8 9 10]';            % specify the two matrices
B = [0 10 20 30 40 50 60 70 80 90];
C = A+B
assert(all(C(:) == (1:100)') == 1)      % assertion should succeed


fprintf('Part 2 - Loops allowed\n')
%
% 6. Create a script that prints all the integers between 1 and 10, in random order, with pauses of 1 second between each two prints.

for i = randperm(10,10)                 % random permutation of integers from 1 - 10
    fprintf('%d ', i)                   % print the number out with a space in between
    pause(1)                            % pause 1 second between two prints
end


% 7. Generate two random matrices A and B, and compute their product by hand, using loops. 
% The size of the first matrix should be [5, 3] and of the second [3, 5]. 
% Check your code by comparing the loop-computed product with the product that you get from Matlab's A*B.

A = rand(5,3);                          % create matrices A (5x3) and B(3x5)
B = rand(3,5);
C = zeros(5,5);                         % initialize matrix C as all zeros for now

for i = 1:5
    for j = 1:5
        for k = 1:3
            C(i,j) = C(i,j) + A(i,k).*B(k,j);       % compute the product of values in corresponding rows and columns (element-wise), sum them up
        end
    end
end

D = A*B;
assert(all(C(:)==D(:)))                 % assert that our computation by hand is correct


fprintf('\n\nPart 3: Functions\n')

% 8. Write a function function [B] = normalize_rows(A) which uses a single command (one line and no loops) to make the sum in each row of the matrix 1. 
% Use the repmat function. The sum of the entries in each row should be 1, in the matrix output by your function. 

fprintf('\nAn example to verify normalize_rows function: \n')
A = [1 2; 3 4]
B = normalize_rows(A)


% 9. Now write a function function [B] = normalize_columns(A) which instead ensures that the sum in each column is 1.

fprintf('\nAn example to verify normalize_columns function: \n')
A = [1 2; 3 4]
B = normalize_columns(A)


% 10. Create a function function [val] = fib(n) that returns the n-th number (n >= 1) in the Fibonacci sequence 1, 1, 2, 3, 5, 8, 13...
 
fprintf('\nAn example to verify fib function: \n')
fib(10)


% 11. Implement a function function [N] = my_unique(M) that takes in a matrix M, removes duplicate rows from that input matrix and outputs the result as matrix N. 

fprintf('\nAn example to verify my_unique function: \n')

 M = [1 2 3; 3 2 1; 1 1 1; 1 2 3];
 N = my_unique(M)


fprintf('\n\nPart 4: Images\n')

% 12. Read this image into Matlab as a matrix, and write down its dimensions.

I = imread('pittsburgh.png');           % read in the image 
fprintf('\nThe dimensions are ')
disp(size(I))                           % get the dimensions of the image    
figure                        
imshow(I)                               % display the image


% 13. Convert the image into grayscale.

I2 = rgb2gray(I);                       % convert to grayscale
figure
imshow(I2)                              % display the image in grayscale

% 14. Use the function sum and a logical operator which measures equality to a scalar, to determine and write down how many pixels in the grayscale image are equal to 6. Don't use loops.

fprintf('Number of pixels in the grayscale image that are equal to 6: ')
disp(sum(I2(:) == 6))                   % convert it to a vector, find the pixel values that are equal to 6, sum up how many they are


% 15. Find the darkest pixel in the image, and write its value and [row, column] in your answer sheet. Don't use loops. 
% Hint: Convert to a vector first, and use Matlab's ind2sub function. Use Matlab's help to find out how to use that function.

dark = min(I2(:))                                   % convert to a vector, find the min pixel value, i.e. the darkest
[row,col] = ind2sub(size(I2), find(I2==dark))       % use ind2sub to find the row(s) and column(s) of that pixel value


% 16. Consider a 31x31 square (a square with side equal to 31 pixels) that is centered on the darkest pixel from the previous question. 
% Replace all pixels in that square with white pixels (pixels with value 255). Do this with loops.

for i=(row-15):(row+15)                             % 15-15 on the left and right hand side of the center
    for j=(col-15):(col+15)
        I2(i,j) = 255;                            % set all pixels within the square to value 255
    end
end

% 17. Take the previous image with the white square in it. Place a 121x121 gray square (e.g. pixel values 150) at the center of this image. This time you are NOT allowed to use loops. 
% Hint: You can access a range of rows and columns in a matrix; see examples in the tutorial.

center_row = size(I2,1)/2;                                                % get the row value of the center
center_col = size(I2,2)/2;                                                % get the column value of the center

I2(center_row-60:center_row+60,center_col-60:center_col+60) = 150;        % set all pixels within the sqaure to value 150


% 18. Make a new figure, display the modified image (which includes both a white square and gray square), and save the new figure to a file using saveas(gcf, 'new_image.png').

gcf = figure                                % set the handle
imshow(I2)                                  % display the image
saveas(gcf, 'new_image.png')                % save it

% 19. Using the original pittsburgh.png image, compute the scalar average pixel value along each channel (R, G, B) separately, then subtract the average value per channel. 
% Display the resulting image and write it to a file mean_sub.png. 
% If you choose to do this using a new matrix as your image, make sure it is of the same class/datatype (uint8) as the original image; a simple cast would do the job. You may use loops. 
 
counter = 0;                                    % initialize the counter, i.e. how many pixels there are in total
red_sum = 0; green_sum = 0; blue_sum = 0;       % initialize the sum of pixel values for each channel
 
mod_I = double(I);                              % convert to double for math operations
 
 for x = 1:size(I,1)
     for y = 1:size(I,2)
         red_sum = red_sum + mod_I(x,y,1);          % for each channel, sum up their pixel values
         green_sum = green_sum + mod_I(x,y,2);
         blue_sum = blue_sum + mod_I(x,y,3);
         counter = counter + 1;                     % increase the counter
     end
 end
 
 red_mean = red_sum/counter;                        % divide the sum of pixel values by the counter to get the average for each channel
 green_mean = green_sum/counter;
 blue_mean = blue_sum/counter;
 
 I(:,:,1) = I(:,:,1) - red_mean;                    % subtract the average from the original image
 I(:,:,2) = I(:,:,2) - green_mean;
 I(:,:,3) = I(:,:,3) - blue_mean;
 
 figure
 imshow(I);                                         % display the image
 imwrite(I, 'mean_sub.png')                         % write and save it
 
