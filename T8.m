function [ ] = T8(TT, LTT) %X is individual rule requiring historical decisions
%AN Neural Network output portfolio  risky weight A based on rule parameters
global om A i z max_memory;
x = z(1:6,i-(max_memory-1):i);
x = repmat(x, [1, 1, 2]);
x = permute(x, [3, 1, 2]);
xg = x(1, :,:);
om1 = om(TT, :);
om2 = repmat(om1, [1, 1, max_memory]);
for j = 1:LTT
x1 = om2(j, 1:6,:);
x2 = om2(j,7:12, :);
x3 = om2(j,13:18, :);
g = (tanh(((x1.*xg)+x2))).*x3;
gg = sum(g, 2);
gg = squeeze(gg);
ggg = om1(j, 19, 1) + gg;
xxA = (exp(ggg))./(1 + exp(ggg));
xxA = flipud(xxA);
A(TT(j), :) = xxA';
end
end
