function [ Model ] = UpdateModel( s1, a, r, s2, Model )
% Update the environment model
% The model stores predictions of what state will come next given a current
% state and action, and how much reward will the agent get.

% s1: previous state before taking action (a)
% s2: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%                                             s1 and reaching the state s2
% a:  the last executed action

Model(s1,a,1) = s2;
Model(s1,a,2) = r;

