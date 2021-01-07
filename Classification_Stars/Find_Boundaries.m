function accuracy = Find_Boundaries(data, per, n, include_plot, print_cost)
    % Finds the integer number of points based on the input percentage
    num = floor(length(data.bv)*per);
    
    % Finds the x vector for all of the input points
    x = deg_n_vals(data.bv(1:num,:), data.mag(1:num,:), n);
    
    % Learning rate
    lambda = 0.1;
    
    % Loads vectors of 0's and 1's corresponding to if a data point belongs
    % to that class (1) or not (0)
    o = data.o(1:num,:);
    b = data.b(1:num,:);
    a = data.a(1:num,:);
    f = data.f(1:num,:);
    g = data.g(1:num,:);
    k = data.k(1:num,:);
    m = data.m(1:num,:);
    
    % Initializes an alpha vector of the same length as the x vector
    in_alpha = zeros(nchoosek(n+2,2),1);
    
    % Sets some options for minimization
    options = optimset('GradObj', 'on', 'MaxIter', 600);
    
    % Minimizes the cost function for each class
    % to find the boundary for each class
    [alpha_o, cost_o] = fminunc(@(t)(Cost_Function(t, x, o, lambda)), in_alpha, options);
    [alpha_b, cost_b] = fminunc(@(t)(Cost_Function(t, x, b, lambda)), in_alpha, options);
    [alpha_a, cost_a] = fminunc(@(t)(Cost_Function(t, x, a, lambda)), in_alpha, options);
    [alpha_f, cost_f] = fminunc(@(t)(Cost_Function(t, x, f, lambda)), in_alpha, options);
    [alpha_g, cost_g] = fminunc(@(t)(Cost_Function(t, x, g, lambda)), in_alpha, options);
    [alpha_k, cost_k] = fminunc(@(t)(Cost_Function(t, x, k, lambda)), in_alpha, options);
    [alpha_m, cost_m] = fminunc(@(t)(Cost_Function(t, x, m, lambda)), in_alpha, options);
    
    % Creates a large matrix of all alphas and a vector of costs
    alpha = [alpha_o, alpha_b, alpha_a, alpha_f, alpha_g, alpha_k, alpha_m];
    costs = [cost_o, cost_b, cost_a, cost_f, cost_g, cost_k, cost_m];
    %
    % UNCOMMENT THE NEXT TWO LINES TO PRINT ALPHA AND COST
    %
    %disp(alpha);
    %disp(costs);
    
    % Only makes the plot if you said to when calling Find_Boundaries
    if include_plot == true
        % Ready to plot
        hold on;
        
        % Plots all of the individual data points
        Plot_HR(data, num);
        
        % Plots all of the found boundaries in different colors
        plot_boundary(alpha_o,'r',n);
        plot_boundary(alpha_b,'y',n);
        plot_boundary(alpha_a,'g',n);
        plot_boundary(alpha_f,'c',n);
        plot_boundary(alpha_g,'b',n);
        plot_boundary(alpha_k,'m',n);
        plot_boundary(alpha_m,'k',n);
        
        % We're done plotting
        hold off;
    end
    
    % Finds the accuracy of the boundary
    accuracy = find_accuracy(data, alpha, num+1, n, costs);
    
    % Prints all of the costs if you said to when calling Find_Boundaries
    if print_cost == true
        fprintf('Cost of O: %f \n',cost_o);
        fprintf('Cost of B: %f \n',cost_b);
        fprintf('Cost of A: %f \n',cost_a);
        fprintf('Cost of F: %f \n',cost_f);
        fprintf('Cost of G: %f \n',cost_g);
        fprintf('Cost of K: %f \n',cost_k);
        fprintf('Cost of M: %f \n',cost_m);
    end
end  