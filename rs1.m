function [ b ] = rs1(  )
%rs1 Tests performance of agents' current rules
global perf Trader dm1 i a
b = zeros(a, 1);
b = sum(((perf(Trader.Strategy(:,i),:)).*dm1),2);
end
