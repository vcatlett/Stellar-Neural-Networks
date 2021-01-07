function type = plot_back(x1, x2, alphas, n, cost)
    % This function is NOT called by Find_Boundaries
    % It is an alternative way to plot the found boundaries
    % You need to load the data and save the alpha and cost 
    % that Found_Boundaries found
    
    % These are the possible classes
    ans_vals = ['O','B','A','F','G','K','M'];
    
    % Weights the probabilities
    weighted = alphas.*(1./cost);
    
    % Iterate over the grid
    for i = 1:1:(length(x1)-1)
        for j = 1:1:(length(x2)-1)
            % Finds x vector for lower-left corner of rectangle
            xs = deg_n_vals(x1(i), x2(j), n);
            
            % Calls the Sigmoid function for that point
            sig_vals = sigmoid(xs*weighted);
            
            % Determines the highest probability
            [max_val, indx] = max(sig_vals);
            
            % Finds the class corresponding to that probability
            type = ans_vals(indx);
            
            % Decide the color to plot based on the found class
            if type == 'O'
                c = 'r';
            elseif type == 'B'
                c = 'y';
            elseif type == 'A'
                c = 'g';
            elseif type == 'F'
                c = 'c';
            elseif type == 'G'
                c = 'b';
            elseif type == 'K'
                c = 'm';
            elseif type == 'M'
                c = 'k';
            end
            % Colors in that rectangle on the plot
            patch([x1(i) x1(i+1) x1(i+1) x1(i)],[x2(j) x2(j) x2(j+1) x2(j+1)], c, 'EdgeColor', 'none', 'FaceAlpha', 0.1);
        end
    % A counter so you know it's running since it takes awhile
    % You can comment it out, and nothing will break
    disp(i);
    end
    
    % Puts some text on the plot
    xlabel('B-V Color Index (mag)','Fontsize', 15);
    ylabel('Absolute Magnitude (mag)','Fontsize', 15);
    title('Our Network: Highest-Probability Classes', 'FontSize', 20);
    
    % Sets x and y limits
    xlim([-0.5,2.5]);
    ylim([-15, 15]);
    
    % Reverses the y-axis (the stellar magnitude system is flipped)
    set(gca, 'YDir','reverse');
end