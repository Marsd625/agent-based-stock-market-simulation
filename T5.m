function [] = T5(XA)
    global x2 Xs sa1 xs;
%xT5 Produces total demand for shares at current price
Xs = (XA.* sa1)/(x2);
xs = sum(Xs);  
end
