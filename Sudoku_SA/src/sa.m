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

clc;
clear;
close all;

%% Problem Definition

model = CreateModel();    % Create Problem Model

CostFunction = @(model) CalcDiff(model);    % Cost Function

plotSudoku(model);
%% SA Parameters

MaxIt = 750;      % Maximum Number of Iterations

MaxSubIt = 20;    % Maximum Number of Sub-iterations

T0 = 0.025;       % Initial Temp.

alpha = 0.99;     % Temp. Reduction Rate

%% Initialization

% Create and Evaluate Initial Solution
sol.Matrix = CreateRandomSolution(model);
sol.Cost = CostFunction(sol.Matrix);

% Initialize Best Solution Ever Found
BestSol = sol;

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

% Intialize Temp.
T = T0;

%% SA Main Loop

for it = 1:MaxIt
    
    for subit = 1:MaxSubIt
        
        % Create and Evaluate New Solution
        newsol.Matrix = CreateNeighbor(sol.Matrix);
        newsol.Cost = CostFunction(newsol.Matrix);
        
        if newsol.Cost <= sol.Cost % If NEWSOL is better than SOL
            sol = newsol;
            
        else % If NEWSOL is NOT better than SOL, here we sacrifice the worse solution scenario with
             % a certain probability
            
            DELTA = (newsol.Cost-sol.Cost)/sol.Cost;
            
            P = exp(-DELTA/T);
            if rand <= P
                sol = newsol;
            end
            
        end

        % Update Best Solution Ever Found
        if sol.Cost <= BestSol.Cost
            BestSol = sol;
        end
    
    end
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Update Temp.
    T = alpha*T;
    
    % Terminating condition - Found the solution
    if(BestCost(it) == 0)
        disp("Solution found!");
        disp(BestSol.Matrix);
        break;
    end
    
end

%% Results

%displaySudokuConsole(BestSol.Matrix);
plotSudoku(BestSol.Matrix);

%% Additional Functions

% This was my initial function for console printing, but with the
% combinaton of internet I developed the better one under.
% function displaySudokuConsole(model)
% 
%     disp("======================================");
%     disp("============== SOLUTION ==============");
%     disp("======================================");
%     for row = 1:9
%         tempRow = model(row,:);
%         disp("|" + tempRow(1:3) + "|" + tempRow(4:6) + "|" + tempRow(7:9) + "|");
%         disp("_________");
%     end
% end


% Function that plots the solution - Drawing lines
function plotSudoku(matrix)
 
    fig = figure;
    axis off;
    axis equal;
    
    % Draw Sudoku grid
    for i = 0:9
        if mod(i,3) == 0
            % Thick lines for subgrids
            lw = 2;
        else
            % Thin lines for inner grid
            lw = 1;
        end
        line([0, 9], [i, i], 'Color', 'k', 'LineWidth', lw);
        line([i, i], [0, 9], 'Color', 'k', 'LineWidth', lw);
    end
    
    % Fill in numbers
    for i = 1:9
        for j = 1:9
            if matrix(i,j) ~= 0
                text(j-0.5, 9.5-i, num2str(matrix(i,j)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 12);
            end
        end
    end
    
    % Set axes limits - We are solving only 3x3 - modify this in case order
    % increase
    xlim([0, 9]);
    ylim([0, 9]);
end

