function [ total_reward,steps,Q,Model ] = Episode_queue( maxsteps, Q,Model , alpha, gamma,epsilon,theta,statelist,actionlist,grafic,maze,start,goal,temp_setpt,hum_setpt,temp_ext,hum_ext)
% Episode do one episode of the mountain car with sarsa learning
% maxsteps: the maximum number of steps per episode
% statelist: the list of states
% actionlist: the list of actions


x            = start;
steps        = 0;
total_reward = 0;


% convert the continous state variables to an index of the statelist
s   = DiscretizeState(x,statelist);
% selects an action using the epsilon greedy selection strategy
a   = e_greedy_selection(Q,s,epsilon);

% Initialize priority queue
pqueue = PriorityQueue();

t=0;
bulb1_ip = 0;
bulb2_ip = 0;
temp_curr_history = temp_ext;
hum_curr_history = hum_ext;
total_reward_history = 0;
prev_pos = zeros(1,10);             % To store 5 previous states 

wait_steps = 10;
step_plot_lim = wait_steps;

if (grafic==true)
    PlotMaze( x,maze,start,goal );
end

for i=1:maxsteps
    
    % convert the index of the action into an action value
    action = actionlist(a);
    
    %do the selected action and get the next car state
    %[temp_curr, hum_curr, bulb1_ip, bulb2_ip, t]  = DoAction(action, bulb1_ip, bulb2_ip, t, temp_ext, hum_ext);
    
    [bulb1_ip, bulb2_ip, t] = DoActionOnFridge( action, bulb1_ip, bulb2_ip, t );
    %[temp_curr, hum_curr] = ReadFromSensors();
    [temp_curr, hum_curr] = ReadRandom();

    temp_curr_history = [temp_curr_history temp_curr];   % from index 2 as first value is last value of previous step
    hum_curr_history = [hum_curr_history hum_curr];
    temp_curr = temp_curr(end);
    hum_curr = hum_curr(end);
    
    % Current state
    xp = GetState(temp_curr,temp_setpt,hum_curr,hum_setpt); % stands for x prime
    
    % observe the reward at state xp and the final state flag
    if length(find(prev_pos)) < 10
        ind = length(find(prev_pos));
        prev_pos(ind+1:ind+2) = xp;
    else
        prev_pos = [prev_pos(3:10) xp];
    end
    [r,f]   = GetReward( xp,prev_pos );
    total_reward = total_reward + r;
    total_reward_history = [total_reward_history total_reward];
    
    % convert the continous state variables in [xp] to an index of the statelist
    sp  = DiscretizeState(xp,statelist);
    
    % select action prime
    ap = e_greedy_selection(Q,sp,epsilon);
    
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
            subplot(6,10,[1 2 3])
            plot(t,bulb1_ip)
            title('Bulb 1 input over time')
            xlabel('t')
            
            subplot(6,10,[4 5 6])
            plot(t,bulb2_ip)
            title('Bulb 2 input over time')
            xlabel('t')
            
            
            % Plotting current parameter values
            subplot(3,5,6)
            plot(t,temp_curr_history,'r')          
            hold on
            plot(t,temp_setpt*ones(1,length(t)),'--b');
            title('Current temperature plot')
            xlabel('t')
            %legend('Current temperature','Temperature setpoint');
            
            subplot(3,5,7)            
            plot(t, hum_curr_history,'r')
            hold on
            plot(t,hum_setpt*ones(1,length(t)),'--b');
            title('Current humidity plot')
            %legend('Current Humidity','Humidity setpoint');
            
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


