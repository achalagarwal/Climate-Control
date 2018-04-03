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
    if powersupply(1,i)<-10
            r = r - 50000;
    end
    
end
gU = goal+[1,1];
gL = goal-[1,1];
if pos(1)<gU(1) && pos(1)>gL(1) && pos(2)<gU(2) && pos(2)>gL(2)
	r = r + 100000;
    f = true;
else
    r = r - 100;   
    f = false;
end

    


    
