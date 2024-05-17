
function swapNonFixed = CreateNeighbor(model)

    % Empty matrix loaded again to find non-fixed positions
    init_mat = readmatrix('S1.txt');
    
    % Find the square to do swapping in
    targetSquare = randi(9);

    % Map the selected sqare to right coordinates
    switch(targetSquare)
        case 1 
            start_row = 1;
            start_col = 1;
        case 2
            start_row = 1;
            start_col = 4;
        case 3
            start_row = 1;
            start_col = 7;
        case 4 
            start_row = 4;
            start_col = 1;
        case 5
            start_row = 4;
            start_col = 4;
        case 6
            start_row = 4;
            start_col = 7;
        case 7
            start_row = 7;
            start_col = 1;
        case 8
            start_row = 7;
            start_col = 4;
        otherwise
            start_row = 7;
            start_col = 7;
    end

    % Extract the 3x3 sub-grids
    modelSubGrid = model(start_row:start_row+2, start_col:start_col+2);
    initSubGrid = init_mat(start_row:start_row+2, start_col:start_col+2);
             
    % Create 2 arrays that together hold information about the position of
    % non fixed cells
    [nonFixedRows, nonFixedCols] = find(initSubGrid == 0);
    numOfNonFixedCells = numel(nonFixedCols);
    
    % No more swapping options end here
    if(numOfNonFixedCells < 2)
        swapNonFixed = model;
        return;
    end
    
    % Randomly select 2 rows to to the swapping - i used permutations
    swapIndices = randperm(length(nonFixedRows), 2);

    % Fetch the positions for non-fixed cells to swap
    pos1 = [nonFixedRows(swapIndices(1)), nonFixedCols(swapIndices(1))];
    pos2 = [nonFixedRows(swapIndices(2)), nonFixedCols(swapIndices(2))];

    % Swapping - I will show this in documentation detailed
    temp = modelSubGrid(pos1(1),pos1(2));
    modelSubGrid(pos1(1),pos1(2)) = modelSubGrid(pos2(1),pos2(2));
    modelSubGrid(pos2(1),pos2(2)) = temp;

    model(start_row:start_row+2 , start_col:start_col+2) = modelSubGrid;
    swapNonFixed = model;
end