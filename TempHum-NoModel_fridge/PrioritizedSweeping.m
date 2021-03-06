function Q  = PrioritizedSweeping(Q, Model, s, a, r, sp, alpha, gamma, theta, pqueue)
% UpdateQ: update the Qtable and return it using a Prioritized Sweep of the
% state-action space
% s     : previous state before taking action (a)
% a     :  the last executed action
% sp    : current state after action (a)
% r     : reward received from the environment after taking action (a) in state
%         s and reaching the state sp
% theta : the threshold for change in update value p, above which a
%         state-action pair will be put in the queue of updating the QTable
% Q     : the resulting Qtable
% Model : Current estimated model of the environment
% p     : The update value towards which a backup is shifted

% if (r ~= -1)
%     theta = theta + 0.8*abs(r);
% end

p = abs((r + gamma*max(Q(sp,:))) - Q(s,a));
    if (p > theta)
        pqueue.push(1/p,[s a]);
    end

max_updates = 200;
while(pqueue.size ~= 0 && max_updates)
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
    max_updates = max_updates - 1;    
end
