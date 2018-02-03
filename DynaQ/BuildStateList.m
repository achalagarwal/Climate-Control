function [ states ] = BuildStateList(N,M,R)
%BuildStateList builds a state list from a state matrix

x1  = 0:N-1;
x2  = 0:M-1;
x3  = 0:R-1;

% [F{1:3}] = ndgrid({x1,x2,x3});
% 
% for i=3:-1:1
%     G(:,i) = F{i}(:);
% end
% 
% states = unique(G , 'rows');

states = setprod(x1,x2,x3);

end
