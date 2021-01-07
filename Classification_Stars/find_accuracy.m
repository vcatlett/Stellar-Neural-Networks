function accuracy = find_accuracy(data, alpha, num, n, cost)
    % Calls test_fit on the rest of the data
    my_ans = test_fit(data.bv(num:end,:), data.mag(num:end,:), string(data.spec(num:end,:)), alpha, n, cost);
    
    % The values in my_ans(:,3) are 0 if the found class is incorrect
    % and 1 if the found class is correct
    % So the sum of the column divided by the total number
    % gives the fraction which were classified correctly
    accuracy = sum(my_ans(:,3))/length(my_ans(:,3));
end