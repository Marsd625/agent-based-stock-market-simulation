function [ ED ] = auction( x1 )
%Excess Demand function
global x2 xz1 W1 sa1 XA xs
if x1<0.01 %Prevents negative price point inputs
    ED = 1000;
else
x2 = x1; 
xz1 = T1(); %Generates information set according to test price x1
W1 = T2(); %Generates wealth data at current test price
sa1 = T3();%Generates saving vector according to test price/wealth
XA = T6(); %Neural Network generates alpha values for investment allocation
T5(XA); %Generates total demand for shares at current test price
ED = xs-1; %Excess demand
end
end
