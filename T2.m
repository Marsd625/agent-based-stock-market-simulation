function [ W ] = T2(  )
%wealth
global i rf Trader x2 d;
W = (Trader.Stocks(:,i-1).*(x2 +d(i))) + (Trader.Bonds(:,i-1).*(1+rf));
end
