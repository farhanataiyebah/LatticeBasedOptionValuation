tic
clear;
clc;
clf;
NumOfTimeSteps=7;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.25;
elasticity = 1.9999; %elasticity

r = 0.10; %rate

T = 0.5;
K = 95;
StrCallPut='Call';
Underlying=50:150;
[S0_ALL Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices=Asianprices';
plot(S0_ALL,Asianprices,'k')
hold on


[S0_ALL AsianGprices]= asianG_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
AsianGprices=AsianGprices';
plot(S0_ALL,AsianGprices,'g')
hold on

[S0_ALL Europeanprices]= european_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Europeanprices=Europeanprices';
plot(S0_ALL,Europeanprices,'r')
hold on

[blsCallPrice blsPutPrice]=blsprice(Underlying, K, r, T, Sigma);
plot(Underlying,blsCallPrice)
hold on

[S0_ALL Bermudanprices]= bermudan_prices(Underlying, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Bermudanprices=Bermudanprices';
plot(S0_ALL,Bermudanprices,'c')

hold on
[S0_ALL Americanprices]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
S0_ALL;
Americanprices=Americanprices';
plot(S0_ALL,Americanprices,'m')



legend('Asian Arithmetic','Asian Geometric','European','blsPrice','Bermudan','American')
title('Call Prices under CEV');
xlabel('Underlying');
ylabel('Call Prices');
axis tight
hold off

%saveas(gcf,'callpricing.png')
toc