function Q  = PrioritizedSweeping(Q, Model, s, a, r, sp, alpha, gamma, theta, pqueue)
% UpdateQ update de Qtable and return it using Whatkins Q-Learing
% s1: previous state before taking action (a)
% s2: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%                                             s1 and reaching the state s2
% a:  the last executed action
% tab: the current Qtable
% alpha: learning rate
% gamma: discount factor
% Q: the resulting Qtable

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

