
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
dynamics.elasticity = 1.999;
dynamics.volcoeff = 0;
dynamics.r = 0.1;
dynamics.S0 = 95;
FD.SMax = 200;
FD.SMin = 50;
FD.deltaS = 0.1;
FD.deltat = 0.0005;
contract.T = 0.25;
contract.K = 100;
NumOfTimeSteps=8;
 Sigma=0.15;
 lambda=sqrt(1.5);
 SgridM=2*NumOfTimeSteps+1;
 StrCallPut='Put';
 S0=dynamics.S0;
 K=contract.K;
 T=contract.T;
 r=dynamics.r;
% CEV.m will give us option prices for ALL S0 from SMin to SMax
% But let's display only a few near 100.
displayStart = dynamics.S0-FD.deltaS.*1.5;
displayEnd = dynamics.S0+FD.deltaS.*1.5;
[S0_ALL putprice] = CEV_last(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM, StrCallPut);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
disp([S0_ALL(indices) putprice(indices)])
%% Part b: calculating the delta and gamma.
putprice_0 = putprice(indices);
DELTA = (putprice_0(1) - putprice_0(3)) ./ (2*FD.deltaS)
%[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,Sigma );
% blsPutDelta

%GAMMA = (putprice_0(1) - (2*putprice_0(2)) + putprice_0(3)) ./ (FD.deltaS^2)
%G=blsgamma(  S0 , K , r , T ,Sigma )

