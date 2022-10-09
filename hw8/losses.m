% compute hinge loss for each of the weight matrices
w1_loss_1 = hinge_loss(W1*x1,1);
w1_loss_2 = hinge_loss(W1*x2,2);
w1_loss_3 = hinge_loss(W1*x3,3);
w1_loss_4 = hinge_loss(W1*x4,4);

w1_loss = (w1_loss_1+w1_loss_2+w1_loss_3+w1_loss_4)/4;
fprintf('hinge loss for W1 is %s\n', w1_loss);

w2_loss_1 = hinge_loss(W2*x1,1);
w2_loss_2 = hinge_loss(W2*x2,2);
w2_loss_3 = hinge_loss(W2*x3,3);
w2_loss_4 = hinge_loss(W2*x4,4);

w2_loss = (w2_loss_1+w2_loss_2+w2_loss_3+w2_loss_4)/4;
fprintf('hinge loss for W2 is %s\n', w2_loss);

w3_loss_1 = hinge_loss(W3*x1,1);
w3_loss_2 = hinge_loss(W3*x2,2);
w3_loss_3 = hinge_loss(W3*x3,3);
w3_loss_4 = hinge_loss(W3*x4,4);

w3_loss = (w3_loss_1+w3_loss_2+w3_loss_3+w3_loss_4)/4;
fprintf('hinge loss for W3 is %s\n', w3_loss);

% compute cross entropy loss
w1_loss_1 = cross_entropy_loss(W1*x1,1);
w1_loss_2 = cross_entropy_loss(W1*x2,2);
w1_loss_3 = cross_entropy_loss(W1*x3,3);
w1_loss_4 = cross_entropy_loss(W1*x4,4);

w1_loss = (w1_loss_1+w1_loss_2+w1_loss_3+w1_loss_4)/4;
fprintf('cross entropy loss for W1 is %s\n', w1_loss);

w2_loss_1 = cross_entropy_loss(W2*x1,1);
w2_loss_2 = cross_entropy_loss(W2*x2,2);
w2_loss_3 = cross_entropy_loss(W2*x3,3);
w2_loss_4 = cross_entropy_loss(W2*x4,4);

w2_loss = (w2_loss_1+w2_loss_2+w2_loss_3+w2_loss_4)/4;
fprintf('cross entropy loss for W2 is %s\n', w2_loss);

w3_loss_1 = cross_entropy_loss(W3*x1,1);
w3_loss_2 = cross_entropy_loss(W3*x2,2);
w3_loss_3 = cross_entropy_loss(W3*x3,3);
w3_loss_4 = cross_entropy_loss(W3*x4,4);

w3_loss = (w3_loss_1+w3_loss_2+w3_loss_3+w3_loss_4)/4;
fprintf('cross entropy loss for W3 is %s\n', w3_loss);

