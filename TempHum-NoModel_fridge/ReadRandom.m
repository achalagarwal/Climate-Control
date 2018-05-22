function [TempReading, HumReading] = ReadRandom()
TempReading = 30 + 20.*rand(1,5);
HumReading = 15 + 10.*rand(1,5);
end
