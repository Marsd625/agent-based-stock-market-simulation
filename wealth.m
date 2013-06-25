function [  ] = wealth(  )
%Wealth determines agent wealth
global  i rf d p Trader;
Trader.Wealth(:,i) = ((p(i) +d(i)).*Trader.Stocks(:,i-1)) + ((Trader.Bonds(:,i-1).*(1+rf)));
end
