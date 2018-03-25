function rel_humidity = relativeHumidity(ph2o,T)
P = 1013.25;        % Absolute pressure taken to be 1 atm = 1013.25 millibars

% Arden Buck equation for equilibrium vapor pressure in millibars
ph2oeq = (1.0007 + 3.46 * 10^-6 * P)*6.1121*exp(17.502*T/(240.97+T));

if (ph2o>=ph2oeq)
   rel_humidity = 100;
else
   rel_humidity = (ph2o/ph2oeq)*100;
end