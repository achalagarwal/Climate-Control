for i=1:5
    [temp,hum] = ReadFromSensors();
    temp
    hum
    pause(5);
end