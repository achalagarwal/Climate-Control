function Q = TempHumDemo(temp_ext,temp_setpt,hum_ext,hum_setpt,Q,norandom)
% The main function of the training
% use loadedfile = matfile('Q_20_30_25_40.mat');
% and Q_20_30_25_40 = loadedfile.Q_20_30_25_40 to get the Q matrix after
% training.
% save it again using save('Q_20_30_25_40.mat','Q_20_30_25_40');

maxepisodes = 100;

N = 30;     % range for temp_err
M = 30;     % range for hum_err
K = 5;      % coarseness

goal        = [0 0];
maze        = zeros(N/K, M/K);

statelist   = setprod(N/K,M/K);  % the list of states
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,2);

%Generate initial Population
if ~exist('Q','var') || isempty(Q)
Q           = zeros(nstates,nactions); % the Qtable
end
Model       = zeros(nstates,nactions,2); % the environment Model initialized to 0
                                         %(2 layers, one for next state, one for reward)
                                         
% Check if only demo is required using current Q values (no exploration, only exploiting learnt values)
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

count = 0;

for i=1:maxepisodes
    % Reducing alpha with every episode
    count = count+1;
    alpha = alpha_init / count;
    start = GetState(temp_ext,temp_setpt,hum_ext,hum_setpt);
    
    [total_reward,steps,Q,Model] = Episode_queue( maxsteps, Q,Model , alpha, gamma,epsilon,theta,statelist,actionlist,grafic,maze,start,goal,temp_setpt,hum_setpt,temp_ext,hum_ext);

    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    
    epsilon = epsilon*0.9;
    
    xpoints(i)=i-1;
    ypoints(i)=steps;
    subplot(3,5,[11 12 13]);
    plot(xpoints(1:i),ypoints(1:i))
    title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])
    
    drawnow
    
    if (i>2000000)
        grafic=true;
    end
end