function L = CalcDiff(model)
    % L is the cost to be returned
    L = 0;
    % This is a test matrix from the 'Metaheuristics can solve sudoku' -
    % should be 34 and it is 
    % model = [1 2 4 1 5 7 6 9 2 ;
    %          6 5 9 3 4 2 3 8 7;
    %          8 7 3 6 8 9 4 1 5;
    %          4 3 1 6 8 5 4 7 9;
    %          5 2 6 7 1 9 1 3 2;
    %          7 9 8 4 3 2 8 6 5;
    %          2 7 9 7 1 8 8 2 1;
    %          8 4 6 2 9 3 9 3 4;
    %          3 1 5 5 6 4 7 5 6]
    % Iterate through all rows of the sudoku
    for r = 1:9
        temp_row = model(r,:);
        missingNumbersRow = setdiff(1:9, temp_row);
        temp_cost = numel(missingNumbersRow);
        L = L + temp_cost;     
    end

    % Iterate through all columns of the sudoku
    for c = 1:9
        temp_col = model(:,c);
        missingNumbersCol = setdiff(1:9,temp_col);
        temp_cost = numel(missingNumbersCol);
        L = L + temp_cost;
    end

end