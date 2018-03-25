%% CODE 1: Episode in the main function

function [heater_ip, fan_ip, hum_ip] = fcn(temp_curr,temp_prev,temp_setpt,hum_curr,hum_prev,hum_setpt)
% The main function of the training
coder.extrinsic('PriorityQueue');
coder.extrinsic('PrioritizedSweeping');
coder.extrinsic('int2str');
coder.extrinsic('num2str');
coder.extrinsic('bdroot');
coder.extrinsic('set_param');

maxepisodes = 6;

heater_ip = 0;
fan_ip = 0;
hum_ip = 0;

N = 30;     % range for temp_err
M = 30;     % range for hum_err

persistent start;
goal        = [0 0 GetTempRange(temp_setpt)];
maze        = CreateMaze(N, M);

%statelist   = BuildStateList(N,M,3);  % the list of states
[X,Y,Z] = meshgrid(0:N-1,0:M-1,0:2);
statelist   = [X(:) Y(:) Z(:)];
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,1);

%Generate initial Population
Q           = BuildQTable(nstates,nactions ); % the Qtable
Model       = BuildModel(nstates,nactions ); % the Qtable

% planning steps
%p_steps     = 100;

maxsteps    = 3000;  % maximum number of steps per episode
alpha_init  = 0.8;   % initial learning rate for all (s,a) pairs
gamma       = 0.95;  % discount factor
epsilon     = 0.3;   % probability of a random act8ion selection
theta       = 0.1;   % error threshold


grafica     = true; % indicates if display the graphical interface
xpoints=zeros(1,maxepisodes);
ypoints=zeros(1,maxepisodes);

%Number of times a state has been visited (for changing alpha)
Ns = zeros(nstates,nactions);
%alpha = alpha_init.*ones(nstates,nactions);

count = 0;

for i=1:maxepisodes
    % Reducing alpha with every episode
    count = count+1;
    alpha = alpha_init / count;
    start       = GetState(temp_prev,temp_setpt,hum_prev,hum_setpt);
    
    %% Episode started
    
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
    
    for j=1:maxsteps
        
        % convert the index of the action into an action value
        action = actionlist(a);
        
        % do the selected action and get the next car state
        [heater_ip, fan_ip, hum_ip]  = DoAction(action, heater_ip, fan_ip, hum_ip);
        
        % Current state 
        xp = GetState(temp_curr,temp_setpt,hum_curr,hum_setpt);
        
        % observe the reward at state xp and the final state flag
        [r,f]   = GetReward(xp,goal);
        total_reward = total_reward + r;
        
        % convert the continous state variables in [xp] to an index of the statelist
        sp  = DiscretizeState(x,statelist);
        
        % select action prime
        ap = e_greedy_selection(Q,sp,epsilon);
        
        % Update alpha for the (sp,ap) pair
        % Ns(sp,ap) = Ns(sp,ap) + 1;
        % alpha(sp,ap) = alpha(sp,ap) / Ns(sp,ap);
        
        
        % Prioritized Sweeping
        Model = UpdateModel(s,a,r,sp,Model);
        Q = PrioritizedSweeping(Q, Model, s, a, r, sp, alpha, gamma, theta, pqueue);
        
        
        %update the current variables
        s = sp;
        a = ap;
        
        
        %increment the step counter.
        steps=steps+1;
        
        
        % Plot of the mountain car problem
        if (grafica==true)
            Plot( x,maze,goal,'With Proiritized Sweeping');
        end
        
        % if reachs the goal breaks the episode
        if (f==true)
            break
        end
        
    end
    
    
    %% After one episode finished
        
    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    
    epsilon = epsilon*0.9;
    
    % Reducing alpha for visited states
    % alpha(Ns>1) = alpha(Ns>1) ./ Ns(Ns>1);
    
    
    xpoints(i)=i-1;
    ypoints(i)=steps;
    subplot(2,1,2);
    plot(xpoints(1:i),ypoints(1:i))
    title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])
    
    drawnow
    
    if (i>2000000)
        grafica=true;
    end
    
    set_param(bdroot,'SimulationCommand','stop');
    set_param(bdroot,'SimulationCommand','start');

end


%% CODE 2: Episode in a separate function

function [heater_ip, fan_ip, hum_ip] = fcn(temp_curr,temp_prev,temp_setpt,hum_curr,hum_prev,hum_setpt)
% The main function of the training

% Extrinsic calls to these functions which wouldn't otherwise work in
% a MATLAB function block
coder.extrinsic('BuildStateList');
coder.extrinsic('Episode_queue');
coder.extrinsic('int2str');
coder.extrinsic('num2str');
coder.extrinsic('bdroot');
coder.extrinsic('set_param');

maxepisodes = 1;

heater_ip = 0;
fan_ip = 0;
hum_ip = 0;

N = 30;     % range for temp_err
M = 30;     % range for hum_err

persistent start;
goal        = [0 0 GetTempRange(temp_setpt)];
maze        = CreateMaze(N, M);

statelist   = BuildStateList(N,M,3);  % the list of states
% [X,Y,Z] = meshgrid(0:N-1,0:M-1,0:2);
% statelist   = BuildStateList();
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,1);

%Generate initial Population
Q           = BuildQTable(nstates,nactions); % the Qtable
Model       = BuildModel(nstates,nactions); % the Qtable

% planning steps
%p_steps     = 100;

maxsteps    = 3000;  % maximum number of steps per episode
alpha_init  = 0.8;   % initial learning rate for all (s,a) pairs
gamma       = 0.95;  % discount factor
epsilon     = 0.3;   % probability of a random act8ion selection
theta       = 0.1;   % error threshold


grafic     = true; % indicates if display the graphical interface
xpoints=zeros(1,maxepisodes);
ypoints=zeros(1,maxepisodes);

%Number of times a state has been visited (for changing alpha)
Ns = zeros(nstates,nactions);
%alpha = alpha_init.*ones(nstates,nactions);

count = 0;

% Initializing a few variables for MATLAB Coder
total_reward = 0;

for i=1:maxepisodes
    % Reducing alpha with every episode
    count = count+1;
    alpha = alpha_init / count;
    start = GetState(temp_prev,temp_setpt,hum_prev,hum_setpt);
    
    [ total_reward,steps,Q,Model,Ns,heater_ip, fan_ip, hum_ip ] = Episode_queue( maxsteps, Q,Model , alpha, Ns, gamma,epsilon,theta,statelist,actionlist,grafic,maze,start,goal,heater_ip, fan_ip, hum_ip, temp_curr, hum_curr );

    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    
    epsilon = epsilon*0.9;
    
    % Reducing alpha for visited states
    % alpha(Ns>1) = alpha(Ns>1) ./ Ns(Ns>1);
    
    
    xpoints(i)=i-1;
    ypoints(i)=steps;
    subplot(2,1,2);
    plot(xpoints(1:i),ypoints(1:i))
    title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])
    
    drawnow
    
    if (i>2000000)
        grafic=true;
    end
    
    set_param(bdroot,'SimulationCommand','pause');
    set_param
    set_param(bdroot,'SimulationCommand','start');

end