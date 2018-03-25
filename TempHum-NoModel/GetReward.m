function [ r,f ] = GetReward( pos,goal,heater_ip, fan_ip, hum_ip )
% MountainCarGetReward returns the reward at the current state
% x: a vector of position and velocity of the car
% r: the returned reward.
% f: true if the car reached the goal, otherwise f is false
    

% 0 in case of success, -1 for all other moves
if ( floor(abs(pos(1)))<=1 && floor(abs(pos(2)))<=1 ) 
	r = 1000;
    f = true;
% elseif (heater_ip < 0 || heater_ip > 10 || fan_ip < 0 || fan_ip > 10 || hum_ip < 0 || hum_ip > 10)
%     r = -50;   
%     f = false;
% elseif ( abs(pos(1)) < 5 && abs(pos(2)) < 5 ) 
% 	r = 3;
%     f = false;
% elseif ( abs(pos(1)) < 3 && abs(pos(2)) < 3 )
%     r = 5;
%     f = false;
% elseif(pos(3) == goal(3))
%     r = 1;
%     f = false;
elseif (pos(1)>20 || pos(2)>20)
    r = -5;
    f = false;
else
    r = 0;
    f = false;
end