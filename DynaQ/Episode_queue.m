function [ total_reward,steps,Q,Model,Ns,alpha ] = Episode_queue( maxsteps, Q,Model , alpha, Ns, gamma,epsilon,theta,statelist,actionlist,grafic,maze,start,current,goal,p_steps,powersupply )
% Episode do one episode of the mountain car with sarsa learning
% maxstepts: the maximum number of steps per episode
% Q: the current QTable
% alpha: the current learning rate for a (s,a) pair
% gamma: the current discount factor
% epsilon: probablity of a random action
% statelist: the list of states
% actionlist: the list of actions

% Maze
% Programmed in Matlab 
% by:
%  Jose Antonio Martin H. <jamartinh@fdi.ucm.es>
% 
% 



x            = [start,current];
steps        = 0;
total_reward = 0;


% convert the continous state variables to an index of the statelist
s   = DiscretizeState(x,statelist);
% selects an action using the epsilon greedy selection strategy
a   = e_greedy_selection(Q,s,epsilon);
% Update alpha for the (s,a) pair
Ns(s,a) = Ns(s,a) + 1;
%alpha(s,a) = alpha(s,a) / Ns(s,a);

% Initialize priority queue
pqueue = PriorityQueue();

for i=1:maxsteps    
        
    % convert the index of the action into an action value
    action = actionlist(a);    
    
    %do the selected action and get the next car state    
    [xp,powersupply]  = DoAction( action , x, maze,powersupply );    
    
    % observe the reward at state xp and the final state flag
    [r,f]   = GetReward(xp,goal,powersupply);
    total_reward = total_reward + r;
    
    % convert the continous state variables in [xp] to an index of the statelist    
    sp  = DiscretizeState(xp,statelist);
    
    % select action prime
    ap = e_greedy_selection(Q,sp,epsilon);
    
    % Update alpha for the (sp,ap) pair
    Ns(sp,ap) = Ns(sp,ap) + 1;
    %alpha(sp,ap) = alpha(sp,ap) / Ns(sp,ap);
    
    
    % Prioritized Sweeping 
    Model = UpdateModel(s,a,r,sp,Model);
    Q = PrioritizedSweeping(Q, Model, s, a, r, sp, alpha, gamma, theta, pqueue);
    
    
    %update the current variables
    s = sp;
    a = ap;
    x = xp;
    
    
    %increment the step counter.
    steps=steps+1;
    
   
    % Plot of the mountain car problem
    if (grafic==true)
        Plot( x,a,steps,maze,start,goal,['PLANNING (N=' num2str(p_steps) ')']);
    end
    
    % if reachs the goal breaks the episode
    if (f==true)
        break
    end
    
end


