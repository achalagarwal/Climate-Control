%% NOTE:
%  The function works only for scalar values of T, rh and ws

function T_apparent = apparentTemp(T,rh,ws)
if(T>26.7)
    %% Heat Index calculation
    % Conversion to Fahrenheit
    T1 = 1.8*T+32;
    
    % Formula for heat index
    hIndex = - 42.379 + (2.04901523 * T1) + (10.14333127 * rh) - (0.22475541 * T1 * rh) - (6.83783 * 10^-3 * T1^2) - (5.481717 * 10^-2 * rh^2)  + (1.22874 * 10^-3 * T1^2 * rh) + (8.5282 * 10^-4 * T1 * rh^2) - (1.99 * 10^-6 * T1^2 * rh^2);
    
    % Converting result back to Celsius
    T_apparent = (hIndex-32)*5/9;
    
elseif(T<=10)
    %% Wind Chill calculation
    % Conversion to Fahrenheit, and miles per hour respectively
    T2 = 1.8*T+32;
    ws1 = 2.23694*ws;
    
    % For wind speed < 3 miles per hour (1.3 meters per sec), no wind chill effect
    if(ws1<3)
        wChill = T2;
    else
    % Formula for wind chill
    wChill = 35.74 + (0.6215 * T2) - (35.75 * ws1^0.16) + (0.4275 * T2 * ws1^0.16);
    end
     
    % Converting result back to Celsius
    T_apparent = (wChill-32)*5/9;

else
    T_apparent = T;
end