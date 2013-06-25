function [XA] = T6()
%AN Neural Network output portfolio risky weight A based on rule parameters
global om i xxA xz1 Trader sn;
x1 = xz1';
x2 = repmat(x1, sn, 1);
x3 = om(:, 1:6);
x4 = om(:, 7:12);
x5 = om(:, 13:18);
g = (tanh((x3.*x2)+x4)).*x5;
gg = sum(g, 2);
ggg = om(:, 19) + gg;
xxA = (exp(ggg))./(1 + exp(ggg));   
XA = xxA(Trader.Strategy(:,i));
end
