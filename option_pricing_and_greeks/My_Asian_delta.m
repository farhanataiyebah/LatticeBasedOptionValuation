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
NumOfTimeSteps=8;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.15;
elasticity = 1.99; %elasticity
%dynamics.volcoeff = 3;
r = 0.10; %rate
%Underlying=(SMax:-deltaS:SMin)';
S0 = 100; %underlying
SMax = 101;
SMin = 99;
deltaS = 0.1;
deltat = 0.0005;
T = 0.25;
K = 100;
StrCallPut='Put';
Underlying=(S0+5*0.1:-deltaS:S0-5*0.1)';
displayStart =S0 -deltaS.*1.5;
displayEnd = S0+deltaS.*1.5;


[S0_ALL Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices=Asianprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = find(S0_ALL > displayStart & S0_ALL < displayEnd);


disp([S0_ALL(indices) Asianprices(indices)]);
Asian_0 = Asianprices(indices);
delta_Asian= (Asian_0(1) - Asian_0(3)) ./ (2.*deltaS);
delta_Asian
%%
[S0_ALL Europeanprices]= European_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Europeanprices=Europeanprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = find(S0_ALL > displayStart & S0_ALL < displayEnd);


disp([S0_ALL(indices) Europeanprices(indices)]);
European_0 = Europeanprices(indices);
delta_European= (European_0(1) - European_0(3)) ./ (2.*deltaS);
delta_European
%%


[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,elasticity );

blsPutDelta


%figure(1)
%for S=50:1:200
%plot(S,cg(elasticity,Srtike,S,T,t,sigma0,r,q,S0),'b.-')
%hold on
%plot(S,CN_gama_app(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S),'r.-')
%legend('analytical','approximate')
%end


