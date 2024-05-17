%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA105
% Project Title: Simulated Annealing for Traveling Salesman Problem
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Simulated Annealing in MATLAB (URL: https://yarpiz.com/223/ypea105-simulated-annealing), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function sol = CreateRandomSolution(model)

    filledSudokuMatrix = fillSudoku(model);
    disp(filledSudokuMatrix);
    sol = filledSudokuMatrix;
    
end


function filledMatrix = fillSudoku(init_mat)
    % Create a copy of the input matrix to work on
    filledMatrix = init_mat;

    % Iterate over each 3x3 sub-grid
    for rowStart = 1:3:9
        for colStart = 1:3:9
            % Iterate through initial matrix squre by square
            % subGrid is current square to complete
            subGrid = filledMatrix(rowStart:rowStart+2, colStart:colStart+2);

            % This function goes through a square and fetches non-zero
            % values
            presentNumbers = subGrid(subGrid > 0);

            % This function returns the values that are not in the
            % presentNumbers array, look for the missing ones
            missingNumbers = setdiff(1:9, presentNumbers); 

            % Find the positions of the zeros in the sub-grid
            [zeroRows, zeroCols] = find(subGrid == 0);

            % Randomly shuffle the missing numbers
            missingNumbers = missingNumbers(randperm(length(missingNumbers)));

            % Fill the zeros with the missing numbers
            for k = 1:length(missingNumbers)
                subGrid(zeroRows(k), zeroCols(k)) = missingNumbers(k);
            end

            % Place the filled sub-grid back into the matrix
            filledMatrix(rowStart:rowStart+2, colStart:colStart+2) = subGrid;
        end
    end
end
