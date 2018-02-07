function [ posp,powersupply ] = DoAction( action, pos,maze,powersupply )
%DoAction: executes the action (a) into the environment
% a: is the direction 
% pos: is the vector containning the position 
fan = powersupply(1,1);
heater = powersupply(1,2);
humidifier = powersupply(1,3);

x = pos(1);
y = pos(2);
xold = x;
yold = y;
cT = pos(3);
cH = pos(4);
[N M] = size(maze);
% h = 6.112*exp(17*cT/(cT+243.5))*cH/(cT+273)
% bounds for x
xmax = N/2; 
xmin = -N/2;

% bounds for y
ymax = M/2; 
ymin = -M/2;

 %1,2 are fan up and down
 %3,4 are heater up and down
if (action==1)
%     cT = cT - 2;
    fan = fan+0.2;
    x = x + 1;
    
elseif (action==2)
%     cT = cT + 2;
    fan = fan-0.4;
    x = x - 2;
elseif (action==3)
%     cT = cT + 2;
    heater = heater + 0.4;
    x = x - 2;
%     cH = cH-1;
    y = y+1;
elseif (action==4)
%     cT = cT - 2;
    heater = heater - 0.4;
    x = x + 2;
elseif (action==5)
%     cH = cH + 2;
    humidifier = humidifier + 0.4;
    y = y -2;
%     cT = cT + 1;
    x = x-1;
elseif (action==6)
    humidifier = humidifier - 0.4;
%     cH = cH - 2;
    y = y+2;
%     cT = cT - 1;
    x = x + 1;
end

x = min(xmax,x);
x = max(xmin,x);

y = min(ymax,y);
y = max(ymin,y);
cT = cT - (x - xold);
cH = cH - (y - yold);

% 
% if maze(x+1,y+1)==1
%     x = pos(1);
%     y = pos(2); 
% end
powersupply = [fan heater humidifier];
posp=[x y cT cH];


%  Humidity = 6.112 * e^[(17.67 * T)/(T+243.5)] * rh * 18.02
%                                                                             (273.15+T) x 100 x 0.08314
% 
% [4.9696]
% 
% [23.643*38.63 23.643+38.63 1]





