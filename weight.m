function [ ] = weight( B )
%weight 
global om;
LB = length(B);
rb = randi(19, LB, 1); %Index vector of om-value weight to be changed
rb1 = -1 + (2).*rand(LB,1);%Vector of new weights
for j = 1:LB;
    om1 = om(B(j), :);
    om1(rb(j)) = rb1(j);
    om(B(j), :) = om1;
end
end
