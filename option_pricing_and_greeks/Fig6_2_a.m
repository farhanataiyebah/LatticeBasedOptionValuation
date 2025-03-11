tic
clear;
clc;
clf;
NumOfTimeSteps=13;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.30;
elasticity = [1.9999 1.5 1.0 0.5 0.05]; %elasticity
%dynamics.volcoeff = 3;
r = 0.10; %rate
%Underlying=(SMax:-deltaS:SMin)';%underlying
%SMax = 101;
%SMin = 99;

T = 23/365;
K = 1200;
StrCallPut='Call';
Underlying=1100:10:1300;
[S0_ALL prices1]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity(1),lambda,SgridM, StrCallPut);
S0_ALL;
prices1=prices1';
plot(S0_ALL,prices1,'k')
hold on

[S0_ALL prices2]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity(2),lambda,SgridM, StrCallPut);
S0_ALL;
prices2=prices2';
plot(S0_ALL,prices2,'r')
hold on

[S0_ALL prices3]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity(3),lambda,SgridM, StrCallPut);
S0_ALL;
prices3=prices3';
plot(S0_ALL,prices3,'b')
hold on

[S0_ALL prices4]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity(4),lambda,SgridM, StrCallPut);
S0_ALL;
prices4=prices4';
plot(S0_ALL,prices4,'c')
hold on

[S0_ALL prices5]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity(5),lambda,SgridM, StrCallPut);
S0_ALL;
prices5=prices5';
plot(S0_ALL,prices5,'m')
hold on
legend('Alpha=1.9999','Alpha=1.5','Alpha=1.0','Alpha=0.5','Alpha=0.05')
title('American Call Prices under CEV in high market volatility 30% ');
xlabel('Underlying');
ylabel('Call Prices');

ylim([0 100]);
axis tight
hold off

%saveas(gcf,'Putpricing.png')
toc