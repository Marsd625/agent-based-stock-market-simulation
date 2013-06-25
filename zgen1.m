function [xz] = zgen1()
%zgen Generates Current Z values
global i d p r rho1 rho2 m1 m2;
xz = zeros(6, 1);
xm1 = (rho1 .* m1(i-1))+ ((1 - rho1) .*p(i));
xm2 = (rho2 .* m2(i-1))+ ((1 - rho2) .*p(i));
xz(1) = (p(i) + d(i) - p(i-1))./(p(i-1));
xz(2) = r(i-1);
xz(3) = r(i-2);
xz(4) = (xz(1).* p(i)) ./ d(i);
if xz(4)<0
    xz(4) = -log(abs(xz(4)));
else
    xz(4) = log(xz(4));
end
xz(5) = (p(i) ./ xm1);
if xz(5)<0
    xz(5) = -log(abs(xz(5)));
else
    xz(5) = log(xz(5));
end
xz(6) = (p(i) ./ xm2);
if xz(6)<0
    xz(6) = -log(abs(xz(6)));
else
    xz(6) = log(xz(6));
end
end
