function Q = TempHumDemo(temp_ext,temp_setpt,hum_ext,hum_setpt,Q,norandom)
% The main function of the training

% Extrinsic calls to these functions which wouldn't otherwise work in
% a MATLAB function block

maxepisodes = 20;

N = 30;     % range for temp_err
M = 30;     % range for hum_err

goal        = [0 0 GetTempRange(temp_setpt)];
maze        = CreateMaze(N, M);

statelist   = BuildStateList(N,M,3);  % the list of states
% [X,Y,Z] = meshgrid(0:N-1,0:M-1,0:2);
% statelist   = BuildStateList();
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,2);

%Generate initial Population
if ~exist('Q','var') || isempty(Q)
Q           = BuildQTable(nstates,nactions); % the Qtable
end
Model       = BuildModel(nstates,nactions); % the Qtable

% Check if only demo is required using  current Q values
if ~exist('norandom','var')
norandom = false;
end

maxsteps    = 3000;  % maximum number of steps per episode
alpha_init  = 0.8;   % initial learning rate for all (s,a) pairs
gamma       = 0.95;  % discount factor
epsilon     = 0.3;   % probability of a random action selection
theta       = 2;   % error threshold

if(norandom) 
    epsilon = 0;
end

grafic     = true; % indicates if display the graphical interface
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
    start = GetState(temp_ext,temp_setpt,hum_ext,hum_setpt);
    
    [total_reward,steps,Q,Model,Ns] = Episode_queue( maxsteps, Q,Model , alpha, Ns, gamma,epsilon,theta,statelist,actionlist,grafic,maze,start,goal,temp_setpt,hum_setpt,temp_ext,hum_ext);

    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    
    epsilon = epsilon*0.9;
    
    % Reducing alpha for visited states
    % alpha(Ns>1) = alpha(Ns>1) ./ Ns(Ns>1);
    
    
    xpoints(i)=i-1;
    ypoints(i)=steps;
    subplot(3,5,[11 12 13]);
    plot(xpoints(1:i),ypoints(1:i))
    title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])
    
    drawnow
end