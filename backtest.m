function [ret] = backtest(x)
%backtest Performance backtest function for any omega vector x
global rf z r n;
x1 = z(1, :)';
x2 = z(2, :)';
x3 = z(3, :)';
x4 = z(4, :)';
x5 = z(5, :)';
x6 = z(6, :)';
a1 = x(1).*x1;
a2 = x(2).*x2;
a3 = x(3).*x3;
a4 = x(4).*x4;
a5 = x(5).*x5;
a6 = x(6).*x6;
b1 = tanh(a1+x(7));
b2 = tanh(a2+x(8));
b3 = tanh(a3+x(9));
b4 = tanh(a4+x(10));
b5 = tanh(a5+x(11));
b6 = tanh(a6+x(12));
c1 = b1.*x(13);
c2 = b2.*x(14);
c3 = b3.*x(15);
c4 = b4.*x(16);
c5 = b5.*x(17);
c6 = b6.*x(18);
d1 = c1+c2+c3+c4+c5+c6;
e1 = d1+x(19);
alpha = ((exp(e1)./(1+ exp(e1))));
alpha1=alpha(1:n-1);
clear alpha;
ret = (alpha1.*r(2:n)') + ((1-alpha1).*(rf));
ret = [ret(1);ret];
end
