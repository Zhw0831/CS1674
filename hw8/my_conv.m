function [Output] = my_conv(Image, Filter, Padding, Stride)

output_size = (size(Image,1)+2*Padding-size(Filter,1))/Stride + 1;      % the row/col size of the output matrix
conv_output = zeros(output_size,output_size);

image_padding = zeros(size(Image,1)+2*Padding,size(Image,2)+2*Padding);     % the image size with padding
image_padding(Padding+1:size(image_padding,1)-Padding,Padding+1:size(image_padding,2)-Padding) = Image;  % put the image to the image_padding

% convolution computation on padded image
f = size(Filter,1);

x_coord = 1;

for i=1:Stride:size(image_padding,1)-f+1
    y_coord = 1;
    for j=1:Stride:size(image_padding,1)-f+1
        m = image_padding(i:i+f-1,j:j+f-1);         % extract the window from the image for computation
        val = sum(sum(m.*Filter));                  % compute element-wise and sum the products
        conv_output(x_coord,y_coord) = val;
        y_coord = y_coord + 1;
    end
    x_coord = x_coord + 1;
end

Output = conv_output;
    
