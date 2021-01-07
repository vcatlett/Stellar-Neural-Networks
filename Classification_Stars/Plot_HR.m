function Plot_HR(data, num)
    % Pulls the spectral type column up to the specified number
    % and converts the entries to strings
    spec = string(data.spec(1:num,:));
    
    % Prepares a figure for plotting
    figure();
    hold on;
    
    % Iterates over the specified number of points
    for i = 1:1:length(spec)
        % Set the point color based on the spectral type
        if spec(i) == 'O'
            plot(data.bv(i), data.mag(i), '.r');
        elseif spec(i) == 'B'
            plot(data.bv(i), data.mag(i), '.y');
        elseif spec(i) == 'A'
            plot(data.bv(i), data.mag(i), '.g');
        elseif spec(i) == 'F'
            plot(data.bv(i), data.mag(i), '.c');
        elseif spec(i) == 'G'
            plot(data.bv(i), data.mag(i), '.b');
        elseif spec(i) == 'K'
            plot(data.bv(i), data.mag(i), '.m');
        elseif spec(i) == 'M'
            plot(data.bv(i), data.mag(i), '.k');
        end
    end
    
    % Adds some text to the plot
    xlabel('B-V (mag)','Fontsize', 15);
    ylabel('Absolute Magnitude (mag)','Fontsize', 15);
    title('Absolute Magnitude vs. B-V Color Index','Fontsize', 20);
    
    % Sets x and y limits
    xlim([-0.5,2.5]);
    ylim([-15, 15]);
    
    % Flips the y-axis (the stellar magnitude system is reversed)
    set(gca, 'YDir','reverse');
    
    % We're done plotting
    hold off;
end