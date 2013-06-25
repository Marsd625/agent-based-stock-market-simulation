function [ ] = stats( r, rf )
%
global n
r1 = r(n-4999:n) + 1 -rf;
r2 = log(r1);
r3(1) = mean(r2);
r3(2) = std(r2);
r3(3)=skewness(r2);
r3(4)=kurtosis(r2);
r4 = quantile(r2, [0.05, 0.25, 0.75, 0.95]);
r3(5) = r4(2)/r4(1);
r3(6) = r4(3)/r4(4);
spec='Return Statistics \n\n Mean = %1.6f \n \n Standard Deviation = %1.6f \n\n Skewness = %1.6f \n\n Kurtosis = %1.6f \n\n Q-L = %1.6f \n\n Q-R = %1.6f';
fprintf(1, spec, r3);
end
