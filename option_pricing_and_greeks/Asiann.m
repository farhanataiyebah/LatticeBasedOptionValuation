%% Pricing an Asian option by Monte Carlo simulation
% Author: Roman Frey
% Date: 08.03.2008
% Contact: roman.frey@student.unisg.ch
% This code shows the pricing of an Asian option by Monte Carlo simulation.
% The general structure of this code is according to Paolo Brandimarte.
% Numerical Methods in Finance. John Wiley & Sons Inc. New York, 2002, p.340.
function Price = Asian(S0,K,r,sigma,T,m,n)
% The variable m denotes the total number of steps whereas n stands for the
% number of simulated paths. Note that increasing m and n both increase
% computation time.
Payoff=zeros(n,1);
for i=1:n
paths=GBM(S0,r,sigma,T,m,1); % According to the function ’Geometric
% Brownian Motion’, which was explained
% in a previous section, this line
% generates asset price sample paths which
% follow a geometric Brownian motion.
Payoff(i)=max(0,K-(prod(paths(2:(m+1))))^(1/length(paths(2:(m+1)))));
% Note that it is taken the current
% arithmetic mean of the asset prices to
% calculate the payoff.
end
Price=exp(-r*T)*Payoff;
SimulatedAsianprice=prod(Price)^(1/length(Price));
Price=SimulatedAsianprice;
end
%%
% After the code is written, we calculate the price of an Asian call option:
% Price=Asian(S0,K,r,sigma,T,m,n);