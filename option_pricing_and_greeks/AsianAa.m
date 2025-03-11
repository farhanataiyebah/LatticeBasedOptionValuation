tic
clear;
clc;
clf;
NumOfTimeSteps=10;
M_Bermudan=2;
lambda=sqrt(1.5);
SgridM=2*NumOfTimeSteps+1;
Sigma=0.30;
elasticity1 =1.9999 ; %elasticity
elasticity2 =1.5;
elasticity3 =1;
elasticity4=0.5;
elasticity5=0.05;


%dynamics.volcoeff = 3;
r = 0.10; %rate

T = 0.5;
K = 95;
StrCallPut='Call';
Underlying=70:130;
[S0_ALL Asianprices1]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity1,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices1=Asianprices1';
plot(S0_ALL,Asianprices1,'k')
hold on

[S0_ALL Asianprices2]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity2,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices2=Asianprices2';
plot(S0_ALL,Asianprices2,'r')
hold on


[S0_ALL Asianprices3]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity3,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices3=Asianprices3';
plot(S0_ALL,Asianprices3,'g')
hold on

[S0_ALL Asianprices4]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity4,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices4=Asianprices4';
plot(S0_ALL,Asianprices4,'b')
hold on


[S0_ALL Asianprices5]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity5,lambda,SgridM, StrCallPut);
S0_ALL;
Asianprices5=Asianprices5';
plot(S0_ALL,Asianprices5,'m')
hold on
legend('alpha=1.9999','alpha=1.5','alpha=1','alpha=0.5','alpha=0.05')
%title('Put Prices under CEV');
xlabel('Underlying');
ylabel('Call Prices');
ylim([0,80])
%saveas(gcf,'CallPrices1.png')
hold off
toc