function [  ] = newrule( TT )
%Protects new rules for grace period
global nr nr_grace
nr(:, 2:nr_grace) = nr(:, 1:(nr_grace-1));
nr(:, 1) = 0;
nr((TT), 1) = 1;
end
