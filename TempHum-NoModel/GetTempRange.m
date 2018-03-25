function temp_range = GetTempRange(temp)
if (temp<=10) 
    temp_range = 0; 
elseif (temp<27)
    temp_range = 1;
else
    temp_range = 2;
end
end