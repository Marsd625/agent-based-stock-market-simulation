%Copyright (c) 2013, Devon Leigh Marshall
%All rights reserved.

%Agent Based Model of Simulated Stock Market

clc
clear
global Trader
Trader = Agent;
global A A1 a B b d dm dm1 dom i init nr_grace max_memory min_memory ... 
    m1 m2 n nr om p perf r rf rho1 rho2 rr sn T z;
tic
%Fixed variables...........................................................
a = 1000; %Quantity of Agents
B = (0.95)^(1/12); %Discounted rate
n = 10000; %Total quantity of time periods
max_memory = 250; %Maximum memory length of agents
min_memory = 50; %Minimum memory length of agents
nr_grace = 10; %Grace Period for newly created strategy profiles
init = max_memory; %Length of initialization period
rho1 = 0.8; %m1 parameter for moving average
rho2 = 0.99; %m2 parameter for moving average
rr = (1/B)-1; %Discount Rate
sn = 250; %Number of Available Trading strategies
gdiv = 1.02;%Dividend growth rate
sdiv =0.06; %Standard deviation of dividends
rfree = 0.01; %Risk-Free Interest Rate

%Agent Setup..............................................
Trader.Wealth = zeros(a, n);
Trader.Savings = zeros(a, n);
Trader.Strategy = zeros(a, n);
Trader.Risky = zeros(a, n);
Trader.Riskfree = zeros(a, n);
Trader.Stocks = zeros(a, n);
Trader.Bonds = zeros(a, n);
Trader.Memory = zeros(a, 1);
Trader.DiscountRate = zeros(a, 1);

%Archival Variables........................................................

A = zeros(sn, max_memory); %Risky Weights suggested by investment strategies
A1 = zeros(sn, 1); %Stores dropped A value for hpg1 reference
d = zeros(1, n); %Dividends
d(1) = 1; %Starting Dividend Payment
div = zeros(1, n); %Dividend series
dm = zeros(sn, max_memory); %Blank Discount Matrix
dm1 = zeros(a, max_memory); % Blank matrix for agent discounting
dom = zeros(20, n); %Blank matrix for recording index value and omega values for most popular strategies
m1 = zeros(1, n); %Moving Average 1
m2 = zeros(1, n); %Moving Average 2
nr = zeros(sn, nr_grace); %Protects new rules for 10 periods
p = zeros(1, n); %Price vector
perf = zeros(sn, max_memory); %Performance Matrix
r = zeros(1, n); %Return on risky Assets
z = zeros(6, n); %Information Set
current_rules = randi(sn, a, 3); %randomly distributes starting strategies
Trader.Strategy(:, 1:3) = current_rules; %Sets starting strategies
om = -1 + (2).*rand(sn,19); %Rule Parameters

%Experimental Variables...................................................

T = randi([min_memory, max_memory], a, 1); %Memory Length


%................................................................

Trader.Memory = T;

%................................................................

sd = ((1+sdiv)^(1/12))-1; %Annualized Standard deviation of dividend series
gd = gdiv.^(1/12); %Annualized growth rate of dividend series
rf = ((1+rfree)^(1/12))-1; %Annualized Risk-Free Interest Rate

%Generates dividend set..................................................
for i = 2:n;
    d(i) = ((d(i-1).*gd)+ (sd.*d(i-1).*randn(1)));
end



%Builds Discount Matrix..................................................
for i = 1:max_memory
    dm(i, i:end) = B.^(0:(max_memory-i));
end
rot90(dm, 2);
dm = dm';
rs3();

%Primers..................................................................
p(1) = d(1)./rr; %Sets Price in period 1
p(2) = d(2)./rr; %Sets Price in period 2
r(1) = d(1)./p(1); %Sets returns in period 1
r(2) = d(2)./p(1); %Sets returns in period 2

Trader.Stocks(:,1:init) = (1/a); %Fixes share holdings through initialization period
       
o = ((p(1)+d(1)).*(1/a));

Trader.Wealth(:,1) = ((p(1)+d(1)).*(1/a)) + (4.*o.*(1+rf));
Trader.Savings(:,1) = B.*Trader.Wealth(:,1);
Trader.Risky(:,1) = 0.2;
Trader.Riskfree(:,1) = 1 - Trader.Risky(:,1);
Trader.Bonds(:,1) = Trader.Riskfree(:,1).*Trader.Wealth(:,1);
Trader.Wealth(:,2) = (p(2)+d(2)).*Trader.Stocks(:,1) + (Trader.Bonds(:,1).*(1+rf));
Trader.Savings(:,2) = B.*Trader.Wealth(:,2);
Trader.Risky(:,2) = (p(2).*Trader.Stocks(:,2))./(Trader.Savings(:,2));
Trader.Riskfree(:,2) = (1-Trader.Risky(:,2));
Trader.Bonds(:,2) = Trader.Riskfree(:,2).*Trader.Wealth(:,2);


%Builds initial information series.........................................
for i = 3:init;
    p(i) = d(i)./rr;
    r(i) = (p(i) + d(i) - p(i-1))./(p(i-1));
    wealth();
    Trader.Savings(:,i) = Trader.Wealth(:,i);
    m1(i) = (rho1 .* m1(i-1))+ ((1 - rho1) .*p(i));
    m2(i) = (rho2 .* m2(i-1))+ ((1 - rho2) .*p(i));
    Trader.Bonds(:,i) = bonds();
    z(:, i) = zgen1();
    Trader.Risky(:,i) = (p(i).*Trader.Stocks(:,i))./(Trader.Savings(:,i));
    Trader.Riskfree(:,i) = (1-(Trader.Risky(:,i)));
    T7();
    hpg();
    Trader.Strategy(:, i+1) = Trader.Strategy(:, i);
end

x1 = p(init);%Primes Search function
%Primary Process........................................................
primary();
%Output Process.....................................................
c = ((1-B).*Trader.Wealth);
ccc = sum(c, 2);
UT = zeros(1, 5000);
for i = 1:5000 
    UT(i) = B.^(i-1);
end
UT1 = repmat(UT, a, 1);
util = sum((UT1.*c(:, (n-4999):n)), 2);
r1 = repmat(r, a, 1);
pr = (Trader.Risky(:, 1:(n-1)).*r1(:, 2:n)) + (Trader.Riskfree(:, 1:(n-1)).*(rf));
xxx = 1:1:sn;
xxy = histc(Trader.Strategy, xxx);
figure;%1
subplot(3, 3, 1); plot(log(p)); xlabel('Time'); ylabel('Log Price');...
    title('Log of Price'); %Plots Price
subplot(3, 3, 2); plot(log(mean(Trader.Wealth))); xlabel('Time');...
    ylabel('Agent Net Worth'); title('Log of Mean Wealth') %Plots Net Worth
subplot(3, 3, 3); plot(r); xlabel('Time'); ylabel('Returns on Risky Asset');...
    title('Returns'); %Plots Price
subplot(3, 3, 4); plot(mean(Trader.Risky)); xlabel('Time'); ylabel('mean ar');...
    title('Average Risky portfolio portion') %Plots Net Worth
subplot(3, 3, 5); plot(log(mean(Trader.Bonds))); xlabel('Time');...
    ylabel('log mean bonds');title('Log of Avg Bond Holdings');%Plots Price
subplot(3, 3, 6); plot(mean(pr)); xlabel('Time');...
    ylabel('Mean Portfolio Returns'); title('Average Portfolio Returns') %Plots Net Worth
subplot(3, 3, 7); scatter(Trader.Memory, Trader.Wealth(:,n), '.');...
    xlabel('Memory'); ylabel('Wealth');title('Memory and Wealth'); %Plots Price
subplot(3, 3, 8); scatter(Trader.Memory, ccc, '.'); xlabel('Memory');...
    ylabel('Consumption'); title('Memory and Consumption') %Plots Net Worth
subplot(3, 3, 9); scatter(Trader.Memory, util, '.'); xlabel('Memory');...
    ylabel('Total Utility');title('Memory and Utility'); %Plots Price
%..........................................................................
%Price Series for Last 500 Periods.........................................
figure;%2
sp = p((n-499):n);
sp1 = smooth(sp, 13);
pbaspect([5, 2, 1]);
plot(sp1);xlabel('Period');ylabel('Price');title({'Price Time Series',''});...
    pbaspect([5, 2, 1]);

%Trading Volume Series.....................................................
figure;%3
clf
for i = 1:500;gg2(:, i) = Trader.Stocks(:,(n-500)+i) - Trader.Stocks(:,(n-501)+i);end;
gg3 = abs(gg2);
gg3 = sum(gg3);
gg4 = smooth(gg3, 13);
plot(gg4);xlabel('Period');ylabel('Volume');...
    title({'Trading Volume Time Series',''});pbaspect([5, 2, 1]);

%Return Series.............................................................
figure;%4
clf
qqq = r((n-1999):n);
qqq1 = qqq-rf;
qqq2 = smooth(qqq1, 13);
plot(qqq2(1001:end));xlabel('Period');ylabel('Returns');...
    title({'Return Time Series',''});pbaspect([5, 2, 1]);

%Dividend/Price Series.....................................................
figure;%5
clf
rrr = d((n-599):end)./p((n-599):end);
rrr1 = rrr+1;
rrr2 = rrr1.^(12);
rrr3 = rrr2-1;
rrr4 = smooth(rrr3, 13);
plot(rrr4(101:end));xlabel('Period');ylabel('Percent Per Year');...
    title({'Dividend/Price Ratio at Annual Rate',''});pbaspect([5, 2, 1]);

%Return Distribution Series................................................
figure;%6
clf
r2 = r((n-(n/2)):n)+1-rf;
r3 = log(r2);
r4 = -0.15:0.005:0.15;
hist(r3, r4);xlabel('Monthly Returns');ylabel('Observations out of 5000');...
    title({'Return Distribution',''});pbaspect([5, 2, 1]); 

%Utility Vs Memory Length..................................................
chart2(Trader.Memory, util, 5, 'b');%7

%Strategy Popularity Series...............................................
chart3(xxy(:, 2:end)');%8
%.........................................................................

%Backtests Popular and Ending Rules.......................................
[a, b] = unique(dom(:, 1000:n)','rows', 'first');
c1 = [b,a];
d1=sortrows(c1);
g = d1';
lb = length(b);
for j = 1:lb;
    bt(:, j) = backtest(g(3:21, j));
end
bt1 = bt(1001:n, :);
bt2=mean(bt1);
[bt3, bt4] = max(bt2);
for j = 1:sn;
    btreturn(j, :) = backtest(om(j, :)');
end
btr1 = btreturn';
btr2 = mean(btr1(1001:end, :));
[btr3, btr4] = max(btr2);
%.........................................................................

%Comapare Backtested Rules.................................................
o = btr4;%Best of End Rules
oa = bt4;%Best of Popular Rules
o1 = btr1(:,o);
o1a = btr1(:,oa);
o4 = mean(pr);
o4(n) = o4((n-1));
o4 = o4';
dddd = btr1(:, sn);
k = 1;
for j = 1:20:n;
    o2(k) = mean(o1((k):(k+20)));
    o2a(k) = mean(o1a((k):(k+20)));
    o4a(k) = mean(o4((k):(k+20)));
    dddd1(k) = mean(dddd((k):(k+20)));
    k = k+1;
end
o3 = smooth(o2, 25);
o3a = smooth(o2a, 25);
o4b = smooth(o4a, 25);
dddd2 = smooth(dddd1, 25);
o3x = o3-o4b;
o3xa = o3a-o4b;
dddd3 = dddd2-o4b;

%Compares Popular and dominant rules.......................................
figure;%9
clf;
subplot(2, 1, 1);
plot(o3x(51:end));xlabel('Period*20');ylabel('Returns over Mkt Avg');...
    title('20-Period Average Returns in Excess of Mkt Avg')
hold on;
plot(o3xa(51:end), 'color', 'r');legend('Dom','Pop');
hold on;
%plot(dddd2(51:500), 'color', 'g');
hold on;
%plot(o4b(51:500), 'color', 'y');
subplot(2, 1, 2);
A2 = d1(:, 2);
plot(xxy(A2, 1000:(n-10))');xlabel('Period');ylabel('Rule Frequency');...
    title('Frequency of Popular Rules')
%Profiles of popular and dominant rules....................................
figure;%10
subplot(2, 1, 1);
plot(om(o, :));title('Dominant Rule Profile');ylabel('Value of om');...
    xlabel('Column Index of om');
subplot(2, 1, 2);
hold on;
plot(om(oa, :), 'color', 'r');title('Popular Rule Profile');...
    ylabel('Value of om');xlabel('Column Index of om');
%Returns dominant strategy produces in excess of the best popular rule
figure;%11
o20=o3x-o3xa;
subplot(2, 1, 1);
plot(o20(51:end));title('Excess Returns of Dom vs Pop');...
    ylabel('20-Period Window'); xlabel('Excess Returns')
subplot(2, 1, 2);
plot(xxy(A2, 1000:(n-10))');xlabel('Period');ylabel('Rule Frequency');...
    title('Frequency of Popular Rules')

%..........................................................................

%Optimum Strategy Path....................................................
k = 1;
for j = 1:20:n;
     pp = btr1((k:(k+20)), :);
     pp1 = mean(pp);
     [pp2(k), pp3(k)] = max(pp1);
     k = k+1;
end;
pp4 = smooth(pp2, 25);
figure;%12
subplot(2, 1, 1);
plot(pp4(51:end));title('Excess Returns of Optimum Strategy');...
    ylabel('Returns'); xlabel('20-Period Window');
subplot(2, 1, 2);
plot(pp3(51:end));title('Best Strategy per Time-Window');...
    ylabel('Strategy index'); xlabel('20-Period Window');
toc
