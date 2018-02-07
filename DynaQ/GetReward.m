function [ r,f ] = GetReward( pos,goal,powersupply )
% MountainCarGetReward returns the reward at the current state
% x: a vector of position and velocity of the car
% r: the returned reward.
% f: true if the car reached the goal, otherwise f is false


% 0 in case of success, -1 for all other moves
r =0;
for i=1:size(powersupply,2)
    if powersupply(1,i)>10
        r = r - 1000;
    end
    if powersupply(1,i)<0
        r = r - 5000;
    end
end

if (pos(1:2)==goal) 
	r = r + 100000;
    f = true;
else
    r = r - 100;   
    f = false;
end

    


    
