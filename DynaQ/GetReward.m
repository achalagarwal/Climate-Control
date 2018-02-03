function [ r,f ] = GetReward( pos,goal )
% MountainCarGetReward returns the reward at the current state
% x: a vector of position and velocity of the car
% r: the returned reward.
% f: true if the car reached the goal, otherwise f is false
    

% 0 in case of success, -1 for all other moves
if ( pos==goal) 
	r = 10;
    f = true;
else
    r = 0;   
    f = false;
end

    


    
