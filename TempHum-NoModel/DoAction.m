function [Temp_apparent, Hum_rel, heater_ip, fan_ip, hum_ip, t] = DoAction( action, heater_ip, fan_ip, hum_ip, t, temp_ext, hum_ext )
%DoAction: executes the action (a) into the environment
 
if (action==1)
    if (heater_ip(end) < 10)
        heater_ip = [heater_ip heater_ip(end)+0.2];
    else
        heater_ip = [heater_ip heater_ip(end)];
    end
    
    fan_ip = [fan_ip fan_ip(end)];
    hum_ip = [hum_ip hum_ip(end)];
elseif (action==2)
    if (heater_ip(end) > 0)
        heater_ip = [heater_ip heater_ip(end)-0.2];
    else
        heater_ip = [heater_ip heater_ip(end)];
    end
    
    fan_ip = [fan_ip fan_ip(end)];
    hum_ip = [hum_ip hum_ip(end)];
elseif (action==3)
    if (fan_ip(end) < 10)
        fan_ip = [fan_ip fan_ip(end)+0.2];
    else
        fan_ip = [fan_ip fan_ip(end)];
    end
    
    hum_ip = [hum_ip hum_ip(end)];
    heater_ip = [heater_ip heater_ip(end)];
elseif (action==4)
    if (fan_ip(end) > 0)
        fan_ip = [fan_ip fan_ip(end)-0.2];
    else
        fan_ip = [fan_ip fan_ip(end)];
    end
    
    hum_ip = [hum_ip hum_ip(end)];
    heater_ip = [heater_ip heater_ip(end)];
elseif (action==5)
    if (hum_ip(end) < 10)
        hum_ip = [hum_ip hum_ip(end)+0.2];
    else
        hum_ip = [hum_ip hum_ip(end)];
    end
    
    fan_ip = [fan_ip fan_ip(end)];
    heater_ip = [heater_ip heater_ip(end)];
elseif (action==6)
    if (hum_ip(end) >= 0)
        hum_ip = [hum_ip hum_ip(end)-0.2];
    else
        hum_ip = [hum_ip hum_ip(end)];
    end
    
    fan_ip = [fan_ip fan_ip(end)];
    heater_ip = [heater_ip heater_ip(end)];
end


heater_ip = [heater_ip heater_ip(end).*ones(1,4)];
fan_ip = [fan_ip fan_ip(end).*ones(1,4)];
hum_ip = [hum_ip hum_ip(end).*ones(1,4)];

t = [t t(end)+1:t(end)+5];
[Temp_apparent, Hum_rel] = GetSystemOutputs(fan_ip, heater_ip, hum_ip, t, temp_ext, hum_ext);

end








