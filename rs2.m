function [ c ] = rs2(  )
%rs2 Tests performance of agents' test rules
global perf dm1 tr sn a
c = zeros(a, 1);
tr = randi(sn, 1000, 1);
c = sum(((perf(tr,:)).*dm1),2);
end
