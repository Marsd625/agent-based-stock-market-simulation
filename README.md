Copyright (c) 2013, Devon Leigh Marshall

All Rights Reserved

agent-based-stock-market-simulation
===================================

This repository is of an agent-based model of a simulated stock market inspired by Blake LeBaron's paper 'Empirical Regularities From Interacting Long-and Short-Memory Investors in an Agent-Based Stock Market.'

To run the program, open the file titled ABM.m and run the script in the Matlab console.

All pertinent variables are conserved in the workspace for subsequent data analysis.

The purpose of this program is to simulate a stock market consisting of artificially intelligent agents who make portfolio decisions on their preferred mix of risky stocks and risk-free bonds. The supply of bonds is unlimited, bonds always pay the same interest rate, and the price of bonds is unaffected by the quantity of bonds being held by agents at any given moment. The risky stocks, however, have a fixed supply which does not change over the course of the simulation. The dividends paid by the stocks grow over time at an average rate, but also fluctuate according to a standard deviation. Likewise, the return to holding a risky stock is determined not only by the dividend, but also by the price of the stock, which is determined according to the agents' collective demand for the stock. 

Prior to the start of each period, agents choose between two investing strategies: one they are currently using, and another which they are presented with at random. Agents choose which strategy to use by backtesting both strategies over the number of periods that corresponds to their memory length. The discount rate dictates that more weight is given to earlier gains or losses than to more recent gains or losses. Agents with longer memories backtest strategy performance over a greater number of periods. 

Each strategy is represented by a 19-element array which is used to build a neural network which then processes a 6-item data set of current market indicators in order to decide the optimal mix of risky and risk-free assets.

Graphical outputs following the completion of the simulation consist of twelve figures that give a statistical breakdown of many key indicators of market movements, agent decision-making, and strategic outcomes. I personally find Figure 8 to be of the most interest as it illustrates crowd behaviors and evolving trading strategies even amongst independant artificially intelligent agents.

The time variable is 'i', and represents one discrete month within the simulation. The choice of months as the unit of time is arbitrary, but it allows for the callibration of variables such as the interest rate and the dividend growth rate to be more realistic. 

Several of the variables are easily adjustable to experiment with market outcomes under different conditons. The variables that should provide the most interesting outcomes are all found in the section labeled "Fixed Variables." These variables will allow you to adjust:
  
  -Number of agents;
  
  -Number of time periods over which trading occurs;
  
  -Discount rate;
  
  -Maximum and minimum memory lengths of the agent population;
  
  -Number of trading strategies available;
  
  -Growth rate of the dividend series;
  
  -Standard deviation of the dividend series;
  
  -Risk-free interest rate;
  
It is likely that many other variables can be adjusted for interesting outcomes, but those under "Fixed Variables" are the only ones I have standardized so as to avoid violating any variable or functional dependencies. 


