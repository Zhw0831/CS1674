function [] = generate_results(filename, reduceAmt, reduceWhat)
    I = imread(filename);                                                       % read in the image
   
    num_rows = size(I,1);                                                       % get the number of rows and columns for later use
    num_cols = size(I,2);
    
    if(strcmp(reduceWhat,'WIDTH'))                                              % if we want to reduce width
        for i = (1:reduceAmt)                                                   % reduce by indicated number of times
            if(i==1)
                reduce_im = reduceWidth(I,true);                                % only set display_flag to true for the first time
                reduce_im = reduceWidth(reduce_im, false);
            end
        end
        agonistic = imresize(I,[num_rows, num_cols-reduceAmt]);                 % the normal "resized" image, not content aware
        name = strcat('Width is reduced by',{' '},num2str(reduceAmt),' pixels'); % the title for the figure
    elseif(strcmp(reduceWhat,'HEIGHT'))                                         % if we want to reduce height
        for i = (1:reduceAmt)                                                   % reduce by indicated number of times
            if(i==1)
                reduce_im = reduceHeight(I,true);                               % only set display_flag to true for the first time
                reduce_im = reduceHeight(reduce_im, false);
            end
        end
        agonistic = imresize(I,[num_rows-reduceAmt, num_cols]);                 % not content aware
        name = strcat('Height is reduced by',{' '},num2str(reduceAmt),' pixels'); % the title of the figure
    end
    
    
    figure;                                                             
    sgtitle(name);                                                      % title for the whole figure
    subplot(1, 3, 1); imshow(I); title('original');                     % subtitle for plot [1,1]
    subplot(1, 3, 2); imshow(reduce_im); title('content-aware');        % subtitle for plot [1,2]
    subplot(1, 3, 3); imshow(agonistic); title('standard');             % subtitle for plot [1,3]
    