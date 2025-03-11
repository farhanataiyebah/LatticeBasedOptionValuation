%% Geometric Brownian motion
% Author: Roman Frey
% Date: 04.03.2008
% Contact: roman.frey@student.unisg.ch
% This code simulates three random asset price paths which are assumed to
% follow a geometric Brownian motion. Note that this is a fairly efficient
% code since it is a so called vectorized code. The general structure of
% this code is according to Paolo Brandimarte. Numerical Methods in
% Finance. John Wiley & Sons Inc. New York, 2002, p.318-319.
function paths = GBM(S0,mu,sigma,T,m,n)
% The variable m denotes the total number of steps whereas n stands for the
% number of simulated paths. Note that increasing m and n both increase
% computation time.
dt = T/m;
drift = (mu-0.5*sigma^2)*dt; % Calculation of the drift term.
diffusion = sigma*sqrt(dt); % Calculation of the diffusion term.
incr = drift + diffusion*randn(n,m);
logpaths = cumsum([log(S0)*ones(n,1),incr],2);
% In a first step we calculate the so
% called logpaths.
paths = exp(logpaths);
end
%%
% After the code is written, we simulate three different asset price paths
% with the following input parameters to generate the GBM paths of Figure 2:
% S(0) = 100
% mu = 5%
% sigma = 40%
% t = 1 year
% steps m = 365, thus dt = 1/365
% number of replications n = 3
%paths=GBM(100,0.05,0.4,1,365,3);
%plot(1:length(paths),paths(1,:))
%hold on
%plot(1:length(paths),paths(2,:))
%hold on
%plot(1:length(paths),paths(3,:))