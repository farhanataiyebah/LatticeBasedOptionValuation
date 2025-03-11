%this script will compute the delta of option prices using polyfit
clear;
clc;
clf;
format long
elasticity = 1.999;

r = 0.1;
T = 0.5;
K = 95;
NumOfTimeSteps=8;
 Sigma=0.15;
 lambda=sqrt(1.5);
 SgridM=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 M_Bermudan=2;
 %dynamics.S0=S0;
 
 Underlying=80:120;
 tic
 format long
 
 [  S0_ALL  Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
deltaAsian=diff(Asianprices)./diff(S0_ALL);
S0_ALL=81:120;
GammaAsian=diff(deltaAsian)./diff(S0_ALL);
plot(S0_ALL(2:end),GammaAsian,'r')

toc
