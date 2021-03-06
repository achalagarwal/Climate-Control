function  MazeDemo()
%MazeDemo, the main function of the demo
%maxepisodes: maximum number of episodes to run the demo

% Maze Problem  
% Programmed in Matlab 
% by:
%  Jose Antonio Martin H. <jamartinh@fdi.ucm.es>
% 
global temp;
global vapour;

maxepisodes = 20;
start       = [10 0];
setGlobalTemp(10);
setGlobalVapour(0);
goal        = [0 0];
current = [10 10];
[maze N M]  = CreateMaze();

powersupply = zeros(1,3);
e = zeros(2,1);

statelist   = BuildStateList(N,M,start,current,e);  % the list of states
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,1);
%Generate initial Population
Q           = BuildQTable(nstates,nactions ); % the Qtable  
Model       = BuildModel(nstates,nactions ); % the Qtable  

% planning steps
p_steps     = 100;

maxsteps    = 5000;  % maximum number of steps per episode
alpha_init  = 0.8;   % initial learning rate for all (s,a) pairs
gamma       = 0.95;  % discount factor
epsilon     = 1;   % probability of a random action selection
theta       = 0.1;   % error threshold


grafica     = true;
; % indicates if display the graphical interface
xpoints=[];
ypoints=[];

%Number of times a state has been visited (for changing alpha)
Ns = zeros(nstates,nactions);
alpha = alpha_init.*ones(nstates,nactions);
tic;
for i=1:maxepisodes    
    
    
    [total_reward,steps,Q,Model,Ns,alpha] =  Episode( maxsteps, Q, Model , alpha, Ns, gamma,epsilon, statelist,actionlist,grafica,maze,start,current,goal,e,p_steps,powersupply) ;  
    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    
    epsilon = epsilon*0.9;
    
    % Reducing alpha for visited states
    alpha(Ns>1) = alpha(Ns>1) ./ Ns(Ns>1);
    
    xpoints(i)=i-1;
    ypoints(i)=steps;
   subplot(2,1,2);
     plot(xpoints,ypoints)      
     title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])    
    
    drawnow
    
%     if (i>2000000)
%         grafica=true;
%     end
end
save('haaa','Q','Model','statelist','start','goal','maze','powersupply');
 Apply(Q,statelist,[start,[10,10]],goal,maze,powersupply);
% for j=1:size(Q,1)
%     for k = 1:size(Q,2)
%         if(Q(i,k)<1)
%             fprintf('state');
%             statelist(i,:)
%             Q(i,:)
%             break;
%         end
%     end
%     Apply(Q,statelist,[9,4,5,9],goal,maze)
end






