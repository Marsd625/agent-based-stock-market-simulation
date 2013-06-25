function [  ] = primary(  )
%Primary Process
global Trader x p i z xz1 om r d dom W1 Xs sa1 XA m1 xm1 m2 xm2 init n
x1 = p(init); %Beginning test price set to price at end of initialization
for i = (init+1):n;
x = fzero(@auction, x1);%Finds equilibrium price
x1 = x; %Sets initial test price for next period
p(i) = x; %Sets Price for current period
AA(); %Generates alpha values for each investment strategy
z(:, i) = xz1; %Records information set produced in equilibrium auction
r(i) = (p(i) + d(i) - p(i-1))/(p(i-1)); %Records returns on risky asset since previous period
Trader.Wealth(:,i) = W1; %Records wealth vector produced in equilibrium auction
Trader.Stocks(:,i) = Xs;%Distributes shares according to demand
Trader.Savings(:,i) = sa1; %Records savings vector for all agents
Trader.Risky(:,i) = XA;%Vector of agent's portion of portofolios composed of risky assets
rfp();%Generates vector of portion of agent's portfolios composed of risk-free assets
Trader.Bonds(:,i) = bonds();%Distributes bonds
m1(i) = xm1;%Moving Average 1
m2(i) = xm2;%Moving Average 2
hpg(); %Records historical performance of each investment strategy according to new information
evolve(); %Modification process for bad rules
rs(); %Rules selection process
dom(1, i) = mode(Trader.Strategy(:,i)); %Records most popular investment strategy
dom(2:20, i) = om(dom(1, i), :); %Records omega-values of most popular strategy
end
end
