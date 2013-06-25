function [  ] = crossover (C, LPT, PT )
%Crossover Performs crossover mutation function to recombine portions of
%two good rules to create a new rule
global om
LC = length(C); %Length of index vector of rules to be modified
RC = randi(LPT, LC, 2); %Parent Rules to be used as good rules in modification
rx = randi(6, LC, 1); %Vector of random values [1:6] determine which moduals from each parent
%rule will be used in new rule
for j = 1:LC;
    om1 = om(PT(RC(j, 1)), :);
    om2 = om(PT(RC(j, 2)), :);
    r1 = rx(j);
    r2 = rx(j)+6;
    r3 = rx(j)+12;
    om1(r1) = om2(r1);
    om1(r2) = om2(r2);
    om1(r3) = om2(r3);
    om(C(j), :) = om1;
end
end
