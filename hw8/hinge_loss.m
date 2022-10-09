function [loss] = hinge_loss(scores, correct_class)

target = scores(correct_class);         % what is the target (correct) class scores we are interested in

total_loss = 0;
for i=1:size(scores)
    if i~=correct_class
        loss_i = max(0,scores(i)-target+1);     % compute the loss
        total_loss = total_loss + loss_i;       % add to the total loss
    end
end

loss = total_loss;