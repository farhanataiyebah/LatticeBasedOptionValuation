function [S AsianPut EuropeanPut BermudanPut AmericanPut] = Put_test(contract,dynamics,FD,elasticity,K,T,Sigma,r,NumOfTimeSteps,lambda,SgridM,M_Bermudan,S0,StrCallPut)
% This script implements the Crank - Nicolson scheme for pricing a vanilla
% put option under the CEV model for the underlying:
%
% dS_t = r * S_t dt + sigma * S_t^alpha dW_t.
%
% It returns a grid of possible initial values of the underlying and
% the correpsonding prices of the put option.
volcoeff = dynamics.volcoeff;
elasticity = dynamics.alpha;
r = dynamics.r;
T = contract.T;
K = contract.K;
% SMin and SMax denote the smallest and largest values of the underlying S.
% The boundary conditions are imposed one step beyond, e.g. at
% S_lowboundary = SMin - deltaS, not at SMin.
SMax = FD.SMax;
SMin = FD.SMin;
deltaS = FD.deltaS;
deltat = FD.deltat;
S = (S0+2*deltaS:-deltaS:S0-2*deltaS)'; % This has to be a column vector.
%S_lowboundary = SMin - deltaS;

[S  AsianPut]=asian_prices(S, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
[S  EuropeanPut]= European_prices(S, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
[S  BermudanPut]= bermudan_prices(S, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, StrCallPut);
[S  AmericanPut]= american_prices(S, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);



end