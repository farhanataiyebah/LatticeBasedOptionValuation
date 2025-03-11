function [S,delta_it,delta_app] = CEV(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0)
% This script implements the Crank - Nicolson scheme for pricing a vanilla
% put option under the CEV model for the underlying:
%
% dS_t = r * S_t dt + sigma * S_t^alpha dW_t.
%
% It returns a grid of possible initial values of the underlying and
% the correpsonding prices of the put option.
volcoeff = dynamics.volcoeff;
alpha = dynamics.alpha;
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
S = (SMax:-deltaS:SMin)'; % This has to be a column vector.
S_lowboundary = SMin - deltaS;

del_sq=sigma0.^2.*S0.^(2-beta);
tau=T-t;
k=(2.*(r-q))./(del_sq.*(2-beta).*(exp((r-q).*(2-beta).*tau)-1));
x=k.*S.^(2-beta).*exp((r-q).*(2-beta).*tau);
y=k.*X.^(2-beta);
if beta<2
delta_it=exp(-q.*tau).* Non_centralChiSquare_Iterate(2.*y,2+(2./(2-beta)),2.*x)+((2.*x.*(2-beta))./S).*((S.*exp(-q.*tau).*Probab_DensityCentralChiSq(2.*y,4+(2./(2-beta)),2.*x)-X.*exp(-r.*tau).*Probab_DensityCentralChiSq(2.*x,2./(2-beta),2.*y)));
delta_app=exp(-q.*tau).* Non_centralChiSquare_Approx(2.*y,2+(2./(2-beta)),2.*x)+((2.*x.*(2-beta))./S).*((S.*exp(-q.*tau).*Probab_DensityCentralChiSq(2.*y,4+(2./(2-beta)),2.*x)-X.*exp(-r.*tau).*Probab_DensityCentralChiSq(2.*x,2./(2-beta),2.*y)));
else
delta_it=exp(-q.*tau).*Non_centralChiSquare_Iterate(2.*x,2./(beta-2),2.*y)-((2.*x.*(2-beta))./S).*((S.*exp(-q.*tau).*Probab_DensityCentralChiSq(2.*x,2./(beta-2),2.*y)-X.*exp(-r.*tau).*Probab_DensityCentralChiSq(2.*y,4+(2./(beta-2)),2.*x))) ;  
delta_app=exp(-q.*tau).* Non_centralChiSquare_Approx(2.*x,2./(beta-2),2.*y)-((2.*x.*(2-beta))./S).*((S.*exp(-q.*tau).*Probab_DensityCentralChiSq(2.*x,2./(beta-2),2.*y)-X.*exp(-r.*tau).*Probab_DensityCentralChiSq(2.*y,4+(2./(beta-2)),2.*x)));   
end
end