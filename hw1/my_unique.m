function [N] = my_unique(M)

% firstly compare each row in M against the rows below that row in M
% if there is no match, i.e. that row is unique, add that row to N
% if there is a match, don't add

N = [];                                     % initialize the empty N matrix for later use
count = 1;                                  % the row number in N where the newly added row from M will go

for i=1:(size(M,1)-1)                       % for rows in M from 1 to the second last row
    flag = 1;                               % indicate whether there is a match. set the initial value to "no match"
    
    T = M(i+1:size(M,1),:);                 % the matrix containing rows starting from the row below the current row being compared in M
    
    if ismember(M(i,:),T,'rows') == 1       % if the row we are comparing has a match in the rows below it
        flag = 0;                           % set flag to "has a match"
    end
    
    if flag==1                              % if there is no match, copy that row into N
        N(count,:) = M(i,:);
        count = count + 1;                  % increase the row counter
    end
end

if ismember(M(size(M,1),:),N,'rows') == 0   % for the last row in M, if it's not among the unique rows yet, i.e. there is no match between it and 
        N(count,:) = M(size(M,1),:);        % other rows, copy it to N

end

        