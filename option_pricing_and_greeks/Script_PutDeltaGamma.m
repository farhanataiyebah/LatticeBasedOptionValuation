tic
clc;
clf;
clear all;
NumOfTimeSteps=8;
%M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.15;
elasticity = 1.999; %elasticity
%dynamics.volcoeff = 3;
r = 0.10; %rate
%Underlying=(SMax:-deltaS:SMin)';
S0 = 79:3:100;
%SMax = 101;
%SMin = 99;
deltaS = 0.1;
%deltat = 0.0005;
T = 0.5;
K = 95;
StrCallPut='Put';
[S0_ALL AsianPutDeltaprices AsianPutGammaprices ]= PutDeltaGammaAsian(S0,deltaS, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
%AsianPutDeltaprices
plot(S0,AsianPutDeltaprices,'r')
hold on

[S0_ALL  EuropeanPutDeltaprices EuropeanPutGammaprices ]= PutDeltaGammaEuropean(S0,deltaS, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
%EuropeanPutDeltaprices
plot(S0,EuropeanPutDeltaprices,'g')
toc