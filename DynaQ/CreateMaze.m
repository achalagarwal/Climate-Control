function [ maze,nrows,ncols ] = CreateMaze()
%CREATEMAZE Summary of this function goes here
%   Detailed explanation goes here
nrows = 30;
ncols = 30;

% Maze base
maze = zeros(nrows,ncols);


%Add some obstacles as ones in the maze
% Sutton and Barto Dyna-Q example maze.
% maze(3,3:5) =1;
% maze(6,2)   =1;
% maze(8,4:6) =1;

end

