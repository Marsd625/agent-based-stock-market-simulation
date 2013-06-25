function [  ] = hpg()
%Primary Historical Performance generator
global i A r rf perf max_memory;
perf(:, (2:max_memory)) = perf(:, (1:(max_memory-1)));
perf(:, 1) = (A(:, 2).*r(i)) + (((1-A(:, 2))).*(rf));
end
