function [loss] = cross_entropy_loss(scores, correct_class)

target = scores(correct_class);         % what is the target (correct) class scores we are interested in

numerator = exp(target);                % numerator in the loss form

denominator = 0;
for i=1:size(scores)
    if i~=correct_class
        loss_i = exp(scores(i));                % compute the loss
        denominator = denominator + loss_i;       % add to the denominator in the loss form
    end
end

loss = -log10(numerator/denominator);