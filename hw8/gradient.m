w1_loss_1 = hinge_loss(W1*x1,1);
w1_loss_2 = hinge_loss(W1*x2,2);
w1_loss_3 = hinge_loss(W1*x3,3);
w1_loss_4 = hinge_loss(W1*x4,4);

previous_loss = (w1_loss_1+w1_loss_2+w1_loss_3+w1_loss_4)/4; % compute the original loss (which is the previous loss as we just start)
current_loss = 0;       % to be computed

original_w1 = W1(:);        % the orginal weight 1 matrix without adding h
h1 = 0.0001;
h2 = 0.001;
gradient_dW = zeros(size(original_w1,1),1);  % initialize the gradient dW vector

for i=1:size(original_w1)
    W1_plus_h = original_w1;           % reset it back to the original W1
    W1_plus_h(i) = W1_plus_h(i) + h1;         % add h
    W1_plus_h = reshape(W1_plus_h,[4,25]);    % reshape W1 for score computation
    % compute the hinge loss
    w1_loss_1 = hinge_loss(W1_plus_h*x1,1);
    w1_loss_2 = hinge_loss(W1_plus_h*x2,2);
    w1_loss_3 = hinge_loss(W1_plus_h*x3,3);
    w1_loss_4 = hinge_loss(W1_plus_h*x4,4);
    current_loss = (w1_loss_1+w1_loss_2+w1_loss_3+w1_loss_4)/4;
    
    gradient_dW(i) = (current_loss - previous_loss)/h1;     % compute gradient
end

disp('gradient for W1 with h=0.0001 is:')
disp(gradient_dW);


for i=1:size(original_w1)
    W1_plus_h = original_w1;           % reset it back to the original W1
    W1_plus_h(i) = W1_plus_h(i) + h2;         % add h
    W1_plus_h = reshape(W1_plus_h,[4,25]);    % reshape W1 for score computation
    % compute the hinge loss
    w1_loss_1 = hinge_loss(W1_plus_h*x1,1);
    w1_loss_2 = hinge_loss(W1_plus_h*x2,2);
    w1_loss_3 = hinge_loss(W1_plus_h*x3,3);
    w1_loss_4 = hinge_loss(W1_plus_h*x4,4);
    current_loss = (w1_loss_1+w1_loss_2+w1_loss_3+w1_loss_4)/4;
    
    gradient_dW(i) = (current_loss - previous_loss)/h2;     % compute gradient
end

disp('gradient for W1 with h=0.001 is:')
disp(gradient_dW);
    
    