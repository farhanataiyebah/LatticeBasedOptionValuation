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
S0 = 89; %underlying
%SMax = 101;
%SMin = 99;
deltaS = 0.2;
deltat = 0.0005;
T = 0.5;
K = 95;
StrCallPut='Put';
Underlying=(S0+2*0.2:-deltaS:S0-2*0.2)';
displayStart =S0 -deltaS.*1.5;
displayEnd = S0+deltaS.*1.5;
tic

[S0_ALL Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL=S0_ALL';
%Asianprices=Asianprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);


%disp([S0_ALL(indices) Asianprices(indices)]);
Asian_0 = Asianprices(indices);
delta_Asian= (Asian_0(1) - Asian_0(3)) / (2*deltaS);
%delta_Asian
GAMMA_Asian = (Asian_0(1) - (2*Asian_0(2)) + Asian_0(3)) / (deltaS^2);


[S0_ALL Europeanprices]= European_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL=S0_ALL';
%Asianprices=Asianprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);


%disp([S0_ALL(indices) Europeanprices(indices)]);
European_0 = Europeanprices(indices);
delta_European= (European_0(1) - European_0(2)) / (deltaS);
%delta_European
GAMMA_European = (European_0(1) - (2*European_0(2)) + European_0(3)) / (deltaS^2);


[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,Sigma );

%blsPutDelta


[S0_ALL Bermudanprices]= bermudan_prices(Underlying, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL=S0_ALL';
%Asianprices=Asianprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);


%disp([S0_ALL(indices) Bermudanprices(indices)]);
Bermudan_0 = Bermudanprices(indices);
delta_Bermudan= (Bermudan_0(1) - Bermudan_0(3)) / (2*deltaS);
%delta_Bermudan
GAMMA_Bermudan = (Bermudan_0(1) - (2*Bermudan_0(2)) + Bermudan_0(3)) / (deltaS^2);

[S0_ALL Americanprices]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL=S0_ALL';
%Asianprices=Asianprices';
%[S0_ALL, AsianPutPrice] = CEV(contract,dynamics,FD,elasticity,Srtike,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);

%disp([S0_ALL(indices) Americanprices(indices)]);
American_0 = Americanprices(indices);
delta_American= (American_0(1) - American_0(3)) / (2*deltaS);
%delta_American
GAMMA_American = (American_0(1) - (2*American_0(2)) + American_0(3)) / (deltaS^2);
delta_Asian
delta_European
blsPutDelta
delta_Bermudan
delta_American

%GAMMA_Asian
%GAMMA_European
%GAMMA_Bermudan
%GAMMA_American



toc







