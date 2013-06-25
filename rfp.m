function [  ] = rfp( )
%Portion of portfolio invested in bonds
global Trader i;
Trader.Riskfree(:,i) = (1 - Trader.Risky(:,i));
end
