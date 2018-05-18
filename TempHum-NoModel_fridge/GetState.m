function state = GetState(temp_curr,temp_setpt,hum_curr,hum_setpt)
temp_curr = floor(temp_curr);
hum_curr = floor(hum_curr);

temp_err = temp_setpt - temp_curr;
hum_err = hum_setpt - hum_curr;

state = [temp_err, hum_err];
end