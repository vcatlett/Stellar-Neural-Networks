function [cost,grad] = Cost_Function(alpha,x,y,lambda)
    % m is the total number of training examples 
    m = length(y);
    
    % Initializing a gradient vector
    grad = zeros(size(alpha));
    
    % Calls the Sigmoid function
    h = sigmoid(x*alpha);
    
    % The actual cost function!
    cost = (-1/m)*sum(y.*log(h)+(1-y).*log(1-h)) + (lambda/(2*m))*sum(alpha.^2);
    
    % Finds the gradient vector 
    % (fminunc needs it to minimize the cost function)
    for i=1:1:length(alpha)
        first_val = (1/m)*sum((h-y).*x);
        if i == 1
            grad(i) = first_val(i);
        else
            grad(i) = first_val(i) + (lambda/m)*alpha(i);
        end
    end
end