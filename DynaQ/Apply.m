function  Apply( Q,statelist,start,goal,maze,powersupply )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% curr = DiscretizeState(start,statelist);
curr = start;
while curr(1)~=goal(1)||curr(2)~=goal(2)
   
     
    z = DiscretizeState(curr,statelist);
    [a id] = sort(Q(z,:),'descend')
    
    fprintf('state');
      statelist(z,:)

    
    i = id(1,1);
    
    curr = DoAction(i,curr,maze,powersupply);
end

