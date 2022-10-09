% encode values: D=4, M=3, K=2
inputs = [10 1 2 3];
weights_layer1 = [0.5 0.6 0.4 0.3; 0.02 0.25 0.4 0.3; 0.82 0.1 0.35 0.3];
weights_layer2 = [0.7 0.45 0.5; 0.17 0.9 0.8];

% compute and print the value of z2, if a tanh activation is used
z2 = tanh(dot(weights_layer1(2,:),inputs));
fprintf('z2 value is %s\n', z2);

% compute and print the value of y1, if RELU activation is used at the hidden layer, and sigmoid activation is used at the output layer
z1 = max(0,dot(weights_layer1(1,:),inputs));
z2 = max(0,dot(weights_layer1(2,:),inputs));
z3 = max(0,dot(weights_layer1(3,:),inputs));
y1 = 1/(1+exp((-1)*dot([z1 z2 z3], weights_layer2(1,:))));
fprintf('y1 value is %s\n', y1);
