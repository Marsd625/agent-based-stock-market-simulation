function [  ] = mutation( Ax )
%Mutation
global om;
LA = length(Ax);
    ra = randi(19, LA, 1); %Weight to be changed
    ra1 = -0.25 + (0.5).*rand(LA,1);%New weight
for j = 1:LA
    om1 = om(Ax(j), :);
    om1(ra(j)) = om1(ra(j)) + ra1(j); %Adds random weight [-0.25, 0.25] to randomly selected omega-value
       if om1(ra(j))>=1 %Check for new value that excedes boundaries
        om1(ra(j)) = om1(ra(j)) - 0.33;
       elseif om1(ra(j))<= -1
        om1(ra(j)) = om1(ra(j)) + 0.33;
       end 
     om(Ax(j), :) = om1;
end
end
