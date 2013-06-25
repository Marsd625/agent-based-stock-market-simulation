function [  ] = hpg1(TT, LTT)
%Secondary Historical Performance generator for replacement rules
global i A A1 r rf perf max_memory;
P1 = i;
P2 = i-(max_memory-1);
b = [A(TT, 2:max_memory), A1(TT)];
c = r(P2:P1);
c = fliplr(c);
c = repmat(c, LTT, 1); 
perf(TT, 1:max_memory) = (b.*c) + ((1-b).*(rf));
end
