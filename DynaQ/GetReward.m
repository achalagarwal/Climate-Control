function [ r,f ] = GetReward( pos,goal )
% MountainCarGetReward returns the reward at the current state
% x: a vector of position and velocity of the car
% r: the returned reward.
% f: true if the car reached the goal, otherwise f is false
    

% 0 in case of success, -1 for all other moves
if (pos(1:2)==goal) 
	r = 1000;
    f = true;
else
    r = -0.5;   
    f = false;
end

    


    
