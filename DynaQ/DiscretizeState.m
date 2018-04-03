function [ s ] = DiscretizeState( x, statelist )
%DiscretizeState check which entry in the state list is more close to x and
%return the index of that entry.

e1=x(5);
e2=x(6);
if e1==0
    e1 = 0;
elseif e1>0 && e1<=5
    e1 = 1;
elseif e1>5 && e1<=15
    e1 = 2;
elseif e1>15 && e1<=30
    e1 = 3;
elseif e1>30 && e1<=50
    e1 = 4;
elseif e1>50
    e1 = 5;
elseif e1<0 && e1>=-5
    e1 = -1;
elseif e1<-5 && e1>=-15
    e1 = -2;
elseif e1<-15 && e1>=-30
    e1 = -3;
elseif e1<-30 && e1>=-50
    e1 = -4;
elseif e1<-50
    e1 = -5;
end
if e2==0
    e2 = 0;
elseif e2>0 && e2<=5
    e2 = 1;
elseif e2>5 && e2<=15
    e2 = 2;
elseif e2>15 && e2<=30
    e2 = 3;
elseif e2>30 && e2<=50
    e2 = 4;
elseif e2>50
    e2 = 5;
elseif e2<0 && e2>=-5
    e2 = -1;
elseif e2<-5 && e2>=-15
    e2 = -2;
elseif e2<-15 && e2>=-30
    e2 = -3;
elseif e2<-30 && e2>=-50
    e2 = -4;
elseif e2<-50
    e2 = -5;
end
x(5) = e1;
x(6) = e2;
[~ ,s] = min(dist(statelist,x'));




