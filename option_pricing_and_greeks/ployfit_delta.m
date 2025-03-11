%this script will compute the delta of option prices using polyfit
clear;
clc;
clf;
format long
elasticity = 1.999;

r = 0.1;
T = 0.5;
K = 95;
NumOfTimeSteps=8;
 Sigma=0.15;
 lambda=sqrt(1.5);
 SgridM=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 M_Bermudan=2;
 %dynamics.S0=S0;
 
 Underlying=80:120;
 tic
 format long
 
 [  S0_ALL  Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
deltaAsian=diff(Asianprices)./diff(S0_ALL);
plot(S0_ALL(2:end),deltaAsian,'r')
hold on

 [  S0_ALL  Euroeanprices]= european_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
deltaEuropean=diff(Euroeanprices)./diff(S0_ALL);
plot(S0_ALL(2:end),deltaEuropean,'g')
hold on

[ blsCallDelta , blsPutDelta ] = blsdelta( Underlying , K , r , T ,Sigma );
plot(Underlying(2:end),blsCallDelta(2:end),'k')
hold on

 [  S0_ALL  Bermudanprices]= bermudan_prices(Underlying, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, StrCallPut);
deltaBermudan=diff(Bermudanprices)./diff(S0_ALL);
plot(S0_ALL(2:end),deltaBermudan,'b')
hold on

[  S0_ALL  Americanprices]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
deltaAmerican=diff(Americanprices)./diff(S0_ALL);
plot(S0_ALL(2:end),deltaAmerican,'m')
legend('delta Asian','delta European','delta bls','delta Bermudan','delta American')
saveas(gcf,'delta.png')
hold off
toc
