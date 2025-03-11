tic
clear;
clc;
clf;
NumOfTimeSteps=6;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.25;
elasticity = 1.9999; %elasticity

r = 0.10; %rate

T = 0.5;
K = 95;
%StrCallPut='Call';
Underlying=50:150;
[S0_ALL call]= bermudan_prices(Underlying, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, 'Call');
S0_ALL;
call=call';
figure(1)
plot(S0_ALL,call,'g')
xlim([50 150])
ylim([0 60])
xlabel('Underlying')
ylabel('Call Prices')
title('Bermudan Call prices under CEV')
hold off

figure(2)
[S0_ALL Put]= bermudan_prices(Underlying, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, 'Put');
S0_ALL;
Put=Put';
plot(S0_ALL,Put,'g')
xlim([50 150])
ylim([0 60])
xlabel('Underlying')
ylabel('Put Prices')
title('Bermudan Put prices under CEV')