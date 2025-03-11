% This script implements the Crank - Nicolson scheme for pricing a vanilla
% put option under the CEV model for the underlying:
%
% dS_t = r * S_t dt + sigma * S_t^alpha dW_t.
%
% The script sets the parameters and calls function CEV.m, where the main
% body of the pricing code lies. Then the script calculates the Greeks and
% the implied volatility curve.
clear;
clc;
beta=0.875;
X=110;
S=100;
T=43;
t=5;
sigma0=0.2;
r=0.03;
q=0.01;
S0=100;
dynamics.alpha = 0.875;
dynamics.volcoeff=0;
dynamics.r = 0.03;
dynamics.S0 = 100;
FD.SMax = 200;
FD.SMin = 50;
FD.deltaS = 0.1;
FD.deltat = 0.0005;
contract.T = 43;
contract.K = 110;
displayStart =dynamics.S0 -FD.deltaS.*1.5;
displayEnd = dynamics.S0+FD.deltaS.*1.5;
[S0_ALL,delta_it,delta_app] = CEV(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
disp([S0_ALL(indices) delta_it(indices) delta_app(indices)]);

%[callputg]=cg(beta,X,S,T,t,sigma0,r,q,S0)
%[gama_it]=CN_gama_it(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0)
%[gama_app]=CN_gama_app(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0)
figure(1)
for S=50:1:200
%plot(S,cg(beta,X,S,T,t,sigma0,r,q,S0),'b.-')
hold on
plot(S,CN_gama_app(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S),'r.-')
%legend('analytical','approximate')
end

