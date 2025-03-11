tic
clear;
clc;
clf;
NumOfTimeSteps=13;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.25;
elasticity = 1.9999; %elasticity

r = 0.10; %rate
m=365;
n=10000;

T = 0.5;
K = 95;
%StrCallPut='Call';
Underlying=50:150;
[S0_ALL Asianpricesput]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, 'Put');
S0_ALL;
Asianpricesput=Asianpricesput';

for i=1:length(Underlying)
    SimulatedAsianprice(i)=AsianPut(Underlying(i),K,r,Sigma,T,m,n);
end


figure(1)

hold on
plot(S0_ALL,Asianpricesput,'r')
plot(Underlying, SimulatedAsianprice,'b')
xlim([50 150])
ylim([0 60])
xlabel('Underlying')
ylabel('Put Prices')

legend ('Asian Arithmetic','Simulated Asian Arithmetic')
title('Asian Arithmetic and Simulated Asian Arithmetic put Prices');

hold off
toc