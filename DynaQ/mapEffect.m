function [ pos, e ] = mapEffect( fan,heater,humidifier )
%MAPEFFECT calculates the change in t , h based on inputs of fan,heater and
%humidifier
%   Detailed explanation goes here
t = getGlobalTemp();
h = getGlobalVapour();
tempHeater = heater*100;
speedFan = fan*10;
vapourIn = humidifier*10;

for i = 1:100
    t = t+ (tempHeater)*100*(0.1+sqrt(speedFan))/1000/1000;
    h = h + (vapourIn)*(0.1+sqrt(speedFan))/10000;
end
e =  zeros(2,1);
%1/10 unit of time
e(1,1)=10*(t-getGlobalTemp());
e(2,1)=10*(h-getGlobalVapour());

pos = [t,h];


end

