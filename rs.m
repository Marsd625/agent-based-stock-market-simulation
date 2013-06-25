function [  ] = rs( )
%Rule Selector
global Trader a i sn;
Trader.Strategy(:,i+1) = Trader.Strategy(:,i); %Current rule selection carried over to next period by default
tr = randi(sn, a, 1); %Index vector of rules to be compared to agent's current rules
b = rs1(); %Generates vector of time-discounted performance of agents' current rules over length of agent memory
c = rs2(); %Generates vector of time-discounted performance of agents' test rules over length of agent memory
f = find(c>b); %Generates index vector of agents where test rule outperformed current rule
Trader.Strategy(f, i+1) = tr(f); %Updates current rule to reflect all agents who swtiched to new rule
end
