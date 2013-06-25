function [  ] = distr( Ax, Bx, Cx, PT )
%distr randomly distributes unused rules across evolution patterns
global LPT sn
rx = randi(3, 1); %Index used to ensure no single modification function is favored
if LPT==(sn-1) %Distributes single rule for modification
    if rx == 1;
        mutation(Ax);
    elseif rx == 2;
        weight(Ax)
    elseif rx == 3;
        crossover(Ax, LPT, PT);
    end
end

if LPT==(sn-1) %Distributes two rules for modification
    if rx == 1;
        mutation(Ax);
        weight(Bx)
    elseif rx == 2;
        weight(Ax)
        crossover(Bx, LPT, PT)
    elseif rx == 3;
        crossover(Ax, LPT, PT);
        mutation(Bx);
    end
end

if LPT<=(sn-3) %distributes three or more rules for modification
    if rx == 1;
        mutation(Ax);
        weight(Bx)
        crossover(Cx, LPT, PT)
    elseif rx == 2;
        weight(Ax)
        crossover(Bx, LPT, PT)
        mutation(Cx)
    elseif rx == 3;
        crossover(Ax, LPT, PT);
        mutation(Bx);
        weight(Cx)
    end
end

end
