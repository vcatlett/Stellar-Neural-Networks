function vals = test_fit(x1, x2, y, alphas, n, cost)
    % All of the possible classes
    ans_vals = ['O','B','A','F','G','K','M'];
    
    % Weight the probabilities
    weighted = alphas.*(1./cost);
    
    % Initialize the vector of answers
    vals = zeros(length(x1),4);
    
    % Iterate over every point
    for i=1:1:length(y)
        % Find the x vector
        xs = deg_n_vals(x1(i), x2(i), n);
        
        % Call sigmoid function on the weighted probabilities
        sig_vals = sigmoid(xs*weighted);
        
        % Find the highest-probability class
        [max_val, indx] = max(sig_vals);
        
        % vals = [Found_Index, True_Class, Correct?, Confidence]
        vals(i,1) = indx;
        vals(i,2) = y;
        vals(i,4) = max_val;
        
        % Is the found class correct?
        if strcmp(ans_vals(indx),y(i))
            vals(i,3) = 1;
        else
            vals(i,3) = 0;
        end
    end
end