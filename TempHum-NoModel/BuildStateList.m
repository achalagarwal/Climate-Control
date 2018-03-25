function [ states ] = BuildStateList(N,M,R)
%BuildStateList builds a state list from a state matrix

x1  = 0:N-1;
x2  = 0:M-1;
x3  = 0:R-1;

states = setprod(x1,x2,x3);

end
