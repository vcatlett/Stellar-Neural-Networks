function big_x = deg_n_vals(x1,x2,n)
    % The number of elements the vector will have
    big_n = nchoosek(n+2,2);
    
    % Initialize a vector for the results
    big_x = zeros(length(x1),big_n);
    
    % Start with the first column
    indx = 1;
    
    % This loop creates every possible combination
    % of powers which sum up to n
    for i = 1:1:n
        for j = 0:1:i
            % The sum of powers is i
            my_ans = (x1.^(i-j)).*(x2.^(j));
            
            % Fills in the column
            big_x(:,indx) = my_ans';
            
            % Moves on to next column
            indx = indx + 1;
        end
    end
    
    % Make a constant term at the end
    big_x(:,end) = 1;
end