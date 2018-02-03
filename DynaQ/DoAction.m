function [ heater_ip, fan_ip, hum_ip ] = DoAction( action, heater_ip, fan_ip, hum_ip )
%DoAction: executes the action (a) into the environment
 
if (action==1)
    heater_ip = heater_ip + 0.2;
elseif (action==2)
    heater_ip = heater_ip - 0.2;
elseif (action==3)
    fan_ip = fan_ip + 0.2;
elseif (action==4)
    fan_ip = fan_ip - 0.2;
elseif (action==5)
    hum_ip = hum_ip + 0.2;
elseif (action==6)
    hum_ip = hum_ip - 0.2;
end
end








