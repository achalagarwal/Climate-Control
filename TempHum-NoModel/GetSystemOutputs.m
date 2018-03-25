function [Temp_apparent, Hum_rel] = GetSystemOutputs(fan_ip, heater_ip, hum_ip, t, temp_ext, hum_ext)

% fansys = tf(4.9696, [23.643*38.63 23.643+38.63 1]);
% heatersys = tf(4.9696, [23.643*38.63 23.643+38.63 1]);
% sprayersys = tf(4.9696, [23.643*38.63 23.643+38.63 1]);

fansys = tf(5,[1 1]);
heatersys = tf(5,[1 1]);
sprayersys = tf(5,[1 1]);

fanout = lsim(fansys,fan_ip,t);
heaterout = lsim(heatersys,-1.*heater_ip,t);
sprayerout = lsim(sprayersys,hum_ip,t);

fanout = fanout(end-5:end)';
heaterout = heaterout(end-5:end)';
sprayerout = sprayerout(end-5:end)';

temp_act = fanout + heaterout + temp_ext;
hum = sprayerout + hum_ext.*ones(1,6);

Hum_rel = zeros(1,6);
Temp_apparent = zeros(1,6);
for i=1:6
    Hum_rel(i) = relativeHumidity(hum(i),temp_act(i));
    Temp_apparent(i) = apparentTemp(temp_act(i),Hum_rel(i),-1*fanout(i));
end

end