% This script implements the Crank - Nicolson scheme for pricing a vanilla
% put option under the CEV model for the underlying:
%
% dS_t = r * S_t dt + sigma * S_t^alpha dW_t.
%
% The script sets the parameters and calls function CEV.m, where the main
% body of the pricing code lies. Then the script calculates the Greeks and
% the implied volatility curve.
tic
clear;
clc;
elasticity=1.999;
K=95;
S=100;
T=0.5;
Sigma=0.15;
r=0.1;
S0=120;
dynamics.alpha = 1.999;
dynamics.volcoeff=3;
dynamics.r = 0.1;
dynamics.S0 = 82;
FD.SMax = 200;
FD.SMin = 50;
FD.deltaS = 0.1;
FD.deltat = 0.0005;
contract.T = 0.5;
contract.K = 95;
NumOfTimeSteps=8;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.15;
elasticity = 1.999; %elasticity
%dynamics.volcoeff = 3;
r = 0.10; %rate
%Underlying=(SMax:-deltaS:SMin)';
S0 = 82;
%SMax = 101;
%SMin = 99;
deltaS = 0.1;
%deltat = 0.0005;
T = 0.5;
K = 95;
StrCallPut='Put';
displayStart =dynamics.S0 -FD.deltaS.*1.5;
displayEnd = dynamics.S0+FD.deltaS.*1.5;
[S0_ALL,AsianPut,EuropeanPut,BermudanPut,AmericanPut] = Put_test(contract,dynamics,FD,elasticity,K,T,Sigma,r,NumOfTimeSteps,lambda,SgridM,M_Bermudan,S0,StrCallPut);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
%disp([S0_ALL(indices) delta_it(indices) delta_app(indices)]);
asian_0 = EuropeanPut(indices);
delta_asian = (asian_0(1) - asian_0(3)) ./ (2.*FD.deltaS)

%[callputg]=cg(beta,X,S,T,t,sigma0,r,q,S0)
%[gama_it]=CN_gama_it(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0)
%[gama_app]=CN_gama_app(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0)
%figure(1)
dynamics.S0=85:-1:80;
dynamics.S0=(dynamics.S0)';

S=85:-1:80;

for i=1:length(S)
    [asian(i) European(i) Bermudan(i) American(i)]=put_test_delta_asian(contract,dynamics,FD,elasticity,K,T,Sigma,r,NumOfTimeSteps,lambda,SgridM,M_Bermudan,S(i),StrCallPut);

delta_asian(i)=asian(i);
delta_European(i)=European(i);
delta_Bermudan(i)=Bermudan(i);
delta_American(i)=American(i);

end
delta_asian
delta_European
delta_Bermudan
delta_American


plot(S,delta_asian,'r')
hold on
plot(S,delta_European,'k')
hold on
plot(S,delta_Bermudan,'g')
hold on
plot(S,delta_American,'b')

toc

