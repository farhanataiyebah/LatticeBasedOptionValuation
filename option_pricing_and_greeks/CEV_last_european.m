function [S,putprice] = CEV_last_european(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM,S0, StrCallPut)
% This script implements the Crank - Nicolson scheme for pricing a vanilla
% put option under the CEV model for the underlying:
%
% dS_t = r * S_t dt + sigma * S_t^alpha dW_t.
%
% It returns a grid of possible initial values of the underlying and
% the correpsonding prices of the put option.
volcoeff = dynamics.volcoeff;
elasticity = dynamics.elasticity;
r = dynamics.r;
T = contract.T;
K = contract.K;
%Underlying=dynamics.S0;
SMax = FD.SMax;
SMin = FD.SMin;
deltaS = FD.deltaS;
deltat = FD.deltat;
dynamics.S0=S0;
Underlying=(dynamics.S0+2*0.1:-deltaS :dynamics.S0-2*0.1)';
% SMin and SMax denote the smallest and largest values of the underlying S.
% The boundary conditions are imposed one step beyond, e.g. at
% S_lowboundary = SMin - deltaS, not at SMin.
%elasticity=elasticity.*2;
[S putprice]= european_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S=S';

end