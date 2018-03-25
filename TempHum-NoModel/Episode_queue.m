function [ total_reward,steps,Q,Model,Ns,heater_ip, fan_ip, hum_ip ] = Episode_queue( maxsteps, Q,Model , alpha, Ns, gamma,epsilon,theta,statelist,actionlist,grafic,maze,start,goal,temp_setpt,hum_setpt,temp_ext,hum_ext)
% Episode do one episode of the mountain car with sarsa learning
% maxstepts: the maximum number of steps per episode
% Q: the current QTable
% alpha: the current learning rate for a (s,a) pair
% gamma: the current discount factor
% epsilon: probablity of a random action
% statelist: the list of states
% actionlist: the list of actions


x            = start;
steps        = 0;
total_reward = 0;


% convert the continous state variables to an index of the statelist
s   = DiscretizeState(x,statelist);
% selects an action using the epsilon greedy selection strategy
a   = e_greedy_selection(Q,s,epsilon);

% Update alpha for the (s,a) pair
% Ns(s,a) = Ns(s,a) + 1;
% alpha(s,a) = alpha(s,a) / Ns(s,a);

% Initialize priority queue
pqueue = PriorityQueue();

t=0;
heater_ip = 0;
fan_ip = 0;
hum_ip = 0;
temp_curr_history = temp_ext;
hum_curr_history = hum_ext;
total_reward_history = 0;

wait_steps = 10;
step_plot_lim = wait_steps;

if (grafic==true)
    PlotMaze( x,maze,start,goal );
end

for i=1:maxsteps
    
    % convert the index of the action into an action value
    action = actionlist(a);
    
    %do the selected action and get the next car state
    [temp_curr, hum_curr, heater_ip, fan_ip, hum_ip, t]  = DoAction(action, heater_ip, fan_ip, hum_ip, t, temp_ext, hum_ext);
    temp_curr_history = [temp_curr_history temp_curr(2:end)];   % from index 2 as first value is last value of previous step
    hum_curr_history = [hum_curr_history hum_curr(2:end)];
    temp_curr = temp_curr(end);
    hum_curr = hum_curr(end);
    
    % Current state
    xp = GetState(temp_curr,temp_setpt,hum_curr,hum_setpt);
    
    % observe the reward at state xp and the final state flag
    [r,f]   = GetReward( xp,goal,heater_ip(end), fan_ip(end), hum_ip(end) );
    total_reward = total_reward + r;
    total_reward_history = [total_reward_history total_reward];
    
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
        PlotMaze(x,maze,start,goal);
        if(steps == step_plot_lim || i==maxsteps || f==true)
            % Plotting inputs to devices            
            subplot(3,5,1)
            plot(t,fan_ip)
            title('Fan input over time')
            xlabel('t')
            
            subplot(3,5,2)
            plot(t,heater_ip)
            title('Heater input over time')
            xlabel('t')
            
            
            subplot(3,5,3)
            plot(t,hum_ip)
            title('Sprayer input over time')
            xlabel('t')
            
            % Plotting current parameter values
            subplot(3,5,6)
            plot(t,temp_curr_history,'r')          
            hold on
            plot(t,temp_setpt*ones(1,length(t)),'--b');
            title('Current temperature plot')
            xlabel('t')
            % legend('Current temperature','Temperature setpoint');
            
            subplot(3,5,7)            
            plot(t, hum_curr_history,'r')
            hold on
            plot(t,hum_setpt*ones(1,length(t)),'--b');
            title('Current humidity plot')
            % legend('Current Humidity','Humidity setpoint');
            
            subplot(3,5,8)
            plot(1:steps+1, total_reward_history,'r')
            title('Total reward history')
            
            step_plot_lim = step_plot_lim + wait_steps;
        end
        drawnow
    end
    
    % if reachs the goal breaks the episode
    if (f==true)
        break
    end
    
end


