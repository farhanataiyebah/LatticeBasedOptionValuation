tic
clear;
clc;
clf;
format long
NumOfTimeSteps=8;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.15;
elasticity = 1.99999; %elasticity
%dynamics.volcoeff = 3;
r = 0.10; %rate
%Underlying=(SMax:-deltaS:SMin)';%underlying
%SMax = 101;
%SMin = 99;
deltaS = 0.1;
deltat = 0.0005;
T = 0.5;
K = 95;
StrCallPut='Call';
Underlying=114.1:-0.1:113.9;

[S0_ALL Europeanprices]= european_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Europeanprices=Europeanprices'
%plot(S0_ALL,Europeanprices,'r')
deltae=(Europeanprices(1) - Europeanprices(3)) ./ (2*deltaS)

[blsCallPrice blsPutPrice]=blsprice(Underlying, K, r, T, Sigma);
blsCallPrice
deltabls=(blsCallPrice(1) - blsCallPrice(3)) ./ (2*deltaS)
toc