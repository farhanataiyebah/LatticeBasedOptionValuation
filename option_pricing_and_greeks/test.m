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
clear;
clc;
format long

NumOfTimeSteps=8;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.15;
elasticity = 1.999; %elasticity
dynamics.volcoeff = 3;
r = 0.10; %rate
%Underlying=(SMax:-deltaS:SMin)';
 %underlying
%SMax = 101;
%SMin = 99;
deltaS = 0.1;
deltat = 0.0005;
T = 0.5;
K = 85;
StrCallPut='Put';

tic
S0 = (80:90)';
for i=1:length(S0)


Underlying=(S0(i)+2*0.1:-deltaS:S0(i)-2*0.1)';
displayStart =S0(i) -deltaS.*1.5;
displayEnd = S0(i)+deltaS.*1.5;

[S0_ALL Europeanprices]= European_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL=(S0_ALL)';
%Asianprices=Asianprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);


%disp([S0_ALL(indices) Europeanprices(indices)]);
European_0 = Europeanprices(indices);
delta_European(i)= (European_0(1) - European_0(2)) / (deltaS);
%delta_European
GAMMA_European(i) = (European_0(1) - (2*European_0(2)) + European_0(3)) / (deltaS^2);



end
[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,Sigma );

blsPutDelta;
plot(S0, delta_European,'r')
hold on
plot(S0, blsPutDelta, 'g')






toc
