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
m=365;
n=10000;
T = 0.5;
K = 95;
Underlying=40:5:160;
[c,p]=blsdelta(Underlying, K, r, T, Sigma);
plot(Underlying,p,'LineWidth',3)
%hold on
%for i=1:length(Underlying)
 %   SimulatedAsianprice(i)=Asian(Underlying(i),K,r,Sigma,T,m,n);
%end
%plot(Underlying, SimulatedAsianprice,'b')
%legend ('Asian Geometric','Simulated Asian Geometric')
%title('Asian Geometric and Simulated Asian Geometric Put Prices');
%xlabel('Underlying');
%ylabel('Put Prices');
%ylim([0,60])
%saveas(gcf,'CallPricesAa.png')
%ylim([0,0.03])
%xlim([40,160])
%axis tight
title('Put Delta (BS) ')
xlabel('Underlying')
ylabel('Put deltas')
toc