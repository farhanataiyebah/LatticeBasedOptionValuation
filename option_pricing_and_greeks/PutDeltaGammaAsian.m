
function [  S0_ALL  AsianPutDeltaprices AsianPutGammaprices ]= PutDeltaGammaAsian(S0,deltaS, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
% This script implements the Crank - Nicolson scheme for pricing a vanilla
% put option under the CEV model for the underlying:
%
% dS_t = r * S_t dt + sigma * S_t^alpha dW_t.
%
% The script sets the parameters and calls function CEV.m, where the main
% body of the pricing code lies. Then the script calculates the Greeks and
% the implied volatility curve.

for i=1:length(S0)
Underlying=(S0(i)+2*0.1:-deltaS:S0(i)-2*0.1);
displayStart =S0(i) -deltaS.*1.5;
displayEnd = S0(i)+deltaS.*1.5;

[S0_ALL Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
%Asianprices=Asianprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);


%disp([S0_ALL(indices) Asianprices(indices)]);
Asian_0 = Asianprices(indices);
delta_Asian(i)= (Asian_0(1) - Asian_0(3)) / (2*deltaS);
AsianPutDeltaprices(i)=delta_Asian(i);
%delta_Asian
GAMMA_Asian(i) = (Asian_0(1) - (2*Asian_0(2)) + Asian_0(3)) / (deltaS^2);
AsianPutGammaprices(i)=GAMMA_Asian(i);
end
end