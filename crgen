function [  ] = crgen(  )
%crgen generates current rules for initialization process
global Trader sn a
hh = 1;
for j = 1:sn;
   Trader.Strategy((hh), 1:3) = j;
   Trader.Strategy((hh + 1), 1:3) = j;
   Trader.Strategy((hh + (a/2)), 1:3) = j;
   Trader.Strategy((hh + (a/2)+1), 1:3) = j;
   hh = hh+2;
end
end
