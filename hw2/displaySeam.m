function displaySeam(im, seam, seamDirection)

    hold on;                                            % use hold on to plot on an existing figure

    if(strcmp(seamDirection, 'HORIZONTAL'))              % if we are plotting the horizontal optimal seam
        x = (1:size(im,2));                             % x ranges from 1 to the number of columns of the image
        plot(x,seam,'r');                                   % plot the seam by the specified x
    elseif(strcmp(seamDirection, 'VERTICAL'))            % if we are plotting the vertical optimal seam
        y = (1:size(im,1));                             % y ranges from 1 to the number of rows of the image
        plot(seam,y,'r');                                   % plot the seam by the specified y
    end
    