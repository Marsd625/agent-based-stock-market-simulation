function [  ] = evolve(  )
%Evolution algorhythm
global Trader i LPT nr sn;
XX = 1:1:sn; %Bins for histogram of rule popularity
[N] = histc(Trader.Strategy(:,((i-9):i)),XX); %Tally of rule usage by agent population over most recent ten periods
M = [N, nr]; %Concatenates histogram with nr to protect recently modified rules
G = sum(M, 2); %Creates vector of total agent selections of each rule over most recent ten periods
PT = find(G); %Index vector of all rules not subject to modification
TT = find(not(G)); %Index vector of all rules to be modified
LPT = length(PT);
newrule(TT); %Updates nr to account for rules about to be modified

if LPT==sn; %Ends evolve if no rules are to be modified
    return
end
LTT = length(TT);
Bx=[]; %Clears historical data 
Cx=[];
%Distribute bad rules into 3 vectors
k = 1;
for j = 1:LTT %Distributes rules to be modified into three separate vectors
    if rem(j+3, 3)==1
        Ax(k) = TT(j);
    elseif rem(j+3, 3)==2
        Bx(k) = TT(j);
    elseif rem(j+3, 3)==0
        Cx(k) = TT(j);
        k = k+1;
    end
end
distr(Ax, Bx, Cx, PT); %Randomly distributes 3 vectors across evolution types
T8(TT, LTT); %Generates historical alpha values for newly modified rules
hpg1(TT, LTT) %Generates historical performance data for newly modified rules
end
