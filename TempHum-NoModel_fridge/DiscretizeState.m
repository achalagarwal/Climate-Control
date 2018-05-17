 function [ s ] = DiscretizeState( x, statelist )
%DiscretizeState checks which entry in the state list is closest to x and
%return the index of that entry.
[d  s] = min(dist(statelist,x'));