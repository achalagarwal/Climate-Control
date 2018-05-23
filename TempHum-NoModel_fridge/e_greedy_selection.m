function [ a ] = e_greedy_selection( Q , s, epsilon )
% e_greedy_selection selects an action using Epsilon-greedy strategy
% Q: the Qtable
% s: the current state

nactions = size(Q,2);

if (rand()>epsilon)             % probability of this happening is (1-epsilon)
    a = GetBestAction(Q,s);    
else
    a = randi(nactions);
end

