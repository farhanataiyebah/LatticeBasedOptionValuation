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
%dynamics.volcoeff = 3;
r = 0.10; %rate

T = 0.5;
K = 95;
StrCallPut='Put';
Underlying=50:150;
[S0_ALL Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices=Asianprices';
plot(S0_ALL,Asianprices,'k')
hold on

[S0_ALL AsianGprices]= asianG_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
AsianGprices=AsianGprices';
plot(S0_ALL,AsianGprices,'r')
hold on


[S0_ALL Europeanprices]= european_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Europeanprices=Europeanprices';
plot(S0_ALL,Europeanprices,'m')
hold on

[blsCallPrice blsPutPrice]=blsprice(Underlying, K, r, T, Sigma);
plot(Underlying,blsPutPrice)
hold on


[S0_ALL Bermudanprices]= bermudan_prices(Underlying, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Bermudanprices=Bermudanprices';
plot(S0_ALL,Bermudanprices,'g')
hold on

[S0_ALL Americanprices]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Americanprices=Americanprices';
plot(S0_ALL,Americanprices,'c')
legend('Asian Arithmetic','Asian Geometric','European','blsPrice','Bermudan','American')
title('Put Prices under CEV');
xlabel('Underlying');
ylabel('Put Prices');
ylim([0,80])
saveas(gcf,'CallPrices1.png')
hold off
toc