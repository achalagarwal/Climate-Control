function  Apply( Q,statelist,start,goal,maze )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% curr = DiscretizeState(start,statelist);
curr = start
curr(1)~=goal(1)&&curr(2)~=goal(2)
while curr(1)~=goal(1)||curr(2)~=goal(2)
   
     
    z = DiscretizeState(curr,statelist);
    fprintf('state');
      statelist(z,:)

    
    i = e_greedy_selection(Q,z,0)
    
    curr = DoAction(i,curr,maze);
end

