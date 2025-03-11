%Asian pricing script
% S(0) = 100
% mu = 5%
% sigma = 40%
% t = 1 year
% steps m = 365, thus dt = 1/365
% number of replications n = 3
S0=100;
K=95;
T=0.5;
r=0.10;
sigma=0.35;
m=365;
n=1000;
Price=Asian(S0,K,r,sigma,T,m,n);
%Asianaa=Binomial_CEV(S0,r,sigma,T,K,5,1.99);