function [Output] = my_pool(Input, Pool_Size)

stride = ceil(size(Input,1)/Pool_Size);
pool_output = zeros(stride,stride);

x_coord = 1;
for i=1:Pool_Size:size(Input,1)
    y_coord = 1;
    for j=1:Pool_Size:size(Input,1)
        m = Input(i:i+Pool_Size-1,j:j+Pool_Size-1);       % extract the window
        val = max(m(:));                            % find the max value
        pool_output(x_coord,y_coord) = val;         % append the max value of the window to the vector
        y_coord = y_coord + 1;
    end
    x_coord = x_coord + 1;
end

Output = pool_output;

