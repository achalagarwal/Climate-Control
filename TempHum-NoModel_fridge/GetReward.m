function [ r,f ] = GetReward( pos,prev_pos )
% pos       : current state (temp_err, hum_err)
% prev_pos  : previous state
% r         : the returned reward.
% f         : true if the car reached the goal, otherwise f is false
% flag      : number of time steps for which the pos (temp_err,hum_err) remains 
%              within a threshold of 5 units.  

prev_pos = abs(prev_pos);
pos = abs(pos);
flag = 0;
% loop from 1 to number of previous states stored
for i = 1:length(find(prev_pos))/2
    if prev_pos(2*i-1) <=5 && prev_pos(2*i) <=5
        flag = flag + 1;
    else
        break;
    end        
end

if flag == 5
    r = 1000;
    f = true;
elseif ( floor(abs(pos(1)))<=5 && floor(abs(pos(2)))<=5 ) 
	r = 1;
    f = false;
elseif (pos(1)>30 || pos(2)>30)
    r = -5;
    f = false;
else
    r = 0;
    f = false;
end