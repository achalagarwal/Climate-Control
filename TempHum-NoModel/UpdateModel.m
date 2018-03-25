function [ Model ] = UpdateModel( s, a, r, sp, Model )
% UpdateQ update de Qtable and return it using Whatkins QLearing
% s1: previous state before taking action (a)
% s2: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%                                             s1 and reaching the state s2
% a:  the last executed action
% tab: the current Qtable
% alpha: learning rate
% gamma: discount factor
% Q: the resulting Qtable

s_temp = 0;
s_temp = s;
Model(s_temp,a,1) = sp;
Model(s_temp,a,2) = r;

