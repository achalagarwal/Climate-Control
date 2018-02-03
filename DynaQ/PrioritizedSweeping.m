function Q  = PrioritizedSweeping(Q, Model, s, a, r, sp, alpha, gamma, theta, pqueue)
% UpdateQ: update the Qtable and return it using a Prioritized Sweep of the
% state-action space
% s: previous state before taking action (a)
% sp: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%   s and reaching the state sp
% a:  the last executed action
% alpha: learning rate
% gamma: discount factor
% theta: the threshold for change in update value p, above which a
%   state-action pair will be put in the queue of updating the QTable
% Q: the resulting Qtable
% Current estimated model of the environment
% p: The update value towards which a backup is shifted


p = abs((r + gamma*max(Q(sp,:))) - Q(s,a));
    if (p > theta)
        pqueue.push(1/p,[s a]);
    end

while(pqueue.size ~= 0)
    sapair = pqueue.pop();
    s = sapair(1);
    a = sapair(2);
    
    sp = Model(s,a,1);
    r = Model(s,a,2);
    Q = UpdateQLearning( s, a, r, sp, Q , alpha, gamma);
    
    [sbar, abar] = find(Model(:,:,1) == s);
    for i = 1:length(sbar)
        rbar = Model(sbar(i),abar(i),2);
        p = abs(rbar + gamma*max(Q(s,:)) - Q(sbar(i),abar(i)));
        if (p > theta)
            pqueue.push(1./p,[sbar(i) abar(i)]);
        end
    end
end

