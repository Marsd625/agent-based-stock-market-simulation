function [  ] = rs3( )
%Generates discount matrix
global a B T dm1 max_memory;
dm1 = zeros(a, max_memory);
for j = 1:a
    for k = 1:T(j)
        dm1(j, k) = B.^(1-k);
    end    
end
end
