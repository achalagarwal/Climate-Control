function [TempReading, HumReading] = ReadFromSensors()

%pause(5);
TempFile = fopen('temp.txt','r');
HumFile = fopen('hum.txt','r');

formatSpec = '%f';
TempReading = fscanf(TempFile,formatSpec)';
HumReading = fscanf(HumFile,formatSpec)';
fclose(TempFile);
fclose(HumFile);

if length(TempReading)<5
    TempReading = [ TempReading TempReading(end)*ones(1,5-length(TempReading)) ];
end
    
if length(HumReading) < 5
    HumReading = [ HumReading HumReading(end)*ones(1,5-length(HumReading)) ];
end

end