function [ states ] = BuildStateList(N,M,start,current,e)
%BuildStateList builds a state list from a state matrix

x1  = -N/2+1:N/2;
x2  = -M/2+1:M/2;
c1 = current(1)-N/2:current(1)+N/2;
c2 = current(2)-M/2:current(2)+M/2;
e1 = -5:5;
e2 = -5:5;
states = setprod(x1,x2,c1,c2,e1, e2);

end
