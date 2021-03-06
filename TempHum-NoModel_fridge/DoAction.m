function [Temp_apparent, Hum_rel, bulb1_ip, bulb2_ip, t] = DoAction( action, bulb1_ip, bulb2_ip, t, temp_ext, hum_ext )
%DoAction: executes the action (a) into the environment
 
if (action==1)
    if (bulb1_ip(end) < 10)
        bulb1_ip = [bulb1_ip bulb1_ip(end)+1];
    else
        bulb1_ip = [bulb1_ip bulb1_ip(end)];
    end
    
    bulb2_ip = [bulb2_ip bulb2_ip(end)];
elseif (action==2)
    if (bulb1_ip(end) > 0)
        bulb1_ip = [bulb1_ip bulb1_ip(end)-1];
    else
        bulb1_ip = [bulb1_ip bulb1_ip(end)];
    end
    
    bulb2_ip = [bulb2_ip bulb2_ip(end)];
elseif (action==3)
    if (bulb2_ip(end) < 10)
        bulb2_ip = [bulb2_ip bulb2_ip(end)+1];
    else
        bulb2_ip = [bulb2_ip bulb2_ip(end)];
    end
    
    bulb1_ip = [bulb1_ip bulb1_ip(end)];
elseif (action==4)
    if (bulb2_ip(end) > 0)
        bulb2_ip = [bulb2_ip bulb2_ip(end)-1];
    else
        bulb2_ip = [bulb2_ip bulb2_ip(end)];
    end
    
    bulb1_ip = [bulb1_ip bulb1_ip(end)];

elseif (action==5)
    bulb2_ip = [bulb2_ip bulb2_ip(end)];
    bulb1_ip = [bulb1_ip bulb1_ip(end)];
end


bulb1_ip = [bulb1_ip bulb1_ip(end).*ones(1,4)];
bulb2_ip = [bulb2_ip bulb2_ip(end).*ones(1,4)];

% pause(x = no of seconds taken to observe temp change, find this time beforehand)
t = [t t(end)+1:t(end)+5];
[Temp_apparent] = GetSystemOutputs(bulb2_ip, bulb1_ip, t, temp_ext, hum_ext);
Hum_rel = hum_ext;
end