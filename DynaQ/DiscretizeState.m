 function [ s ] = DiscretizeState( x, statelist )
%DiscretizeState check which entry in the state list is more close to x and
%return the index of that entry.


s = ceil(strfind(reshape(statelist', [1, numel(statelist)]), x)/size(statelist, 2));