function [  ] = AA(  )
%AA updates Alpha values
global A xxA A1 max_memory
A1 = A(:, max_memory); %Records oldest alpha values for use by hpg
A(:, 2:max_memory) = A(:, 1:(max_memory-1)); %Shifts columns of Alpha Values to appropriate time index
A(:, 1) = xxA; %Updates most recent column of alpha values
end
