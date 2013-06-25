function [] = T7()
%AN Neural Network output portfolio risky weight A based on rule parameters
%Use for updating A
global om  i z xxA A max_memory sn;
A(:, 2:max_memory) = A(:, 1:(max_memory-1));
x1 = z(:, i);
x1 = x1';
x2 = repmat(x1, sn, 1);
x3 = om(:, 1:6);
x4 = om(:, 7:12);
x5 = om(:, 13:18);
g = (((x3.*x2)+x4).*x5);
gg = sum(g, 2);
ggg = om(:, 19) + gg;
xxA = (exp(ggg))./(1 + exp(ggg));
A(:, 1) = xxA;
end
