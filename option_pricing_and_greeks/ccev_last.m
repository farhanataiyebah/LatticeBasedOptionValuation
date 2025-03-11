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
dynamics.elasticity = 1.999;
dynamics.volcoeff = 0;
dynamics.r = 0.1;
%S0 = 95:0.1:105;
FD.SMax = 200;
FD.SMin = 50;
FD.deltaS = 0.1;
FD.deltat = 0.0005;
contract.T = 0.5;
contract.K = 95;
NumOfTimeSteps=15;
 Sigma=0.15;
 lambda=sqrt(1.5);
 SgridM=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 
 K=contract.K;
 T=contract.T;
 r=dynamics.r;
 tic
 format long
S0=80:120;
 for i=1:length(S0)
dynamics.S0(i)=S0(i);
displayStart = dynamics.S0(i)-FD.deltaS.*1.5;
displayEnd = dynamics.S0(i)+FD.deltaS.*1.5;
[S0_ALL,putprice] = CEV_last_asian(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM,S0(i), StrCallPut);
%S0_ALL=S0_ALL';
%underlying=(dynamics.S0+2*0.1:-FD.deltaS :dynamics.S0-2*0.1)';%
%[ blsCallDelta ,putprice ] = blsprice( underlying , K , r , T ,Sigma );%
%S0_ALL=underlying;%
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
%disp([S0_ALL(indices) putprice(indices)]);
%Part b: calculating the delta and gamma.
putprice_0 = putprice(indices);
DELTA = (putprice_0(1) - putprice_0(3)) ./ (2*FD.deltaS);
%[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,Sigma );
% blsPutDelta
%GAMMA = (putprice_0(1) - (2*putprice_0(2)) + putprice_0(3)) ./ (FD.deltaS^2);
%plot(S0,GAMMA,'r.')
delta(i)=DELTA;

 end
 plot(S0,delta,'r')
 hold on
  for i=1:length(S0)
dynamics.S0(i)=S0(i);
displayStart = dynamics.S0(i)-FD.deltaS.*1.5;
displayEnd = dynamics.S0(i)+FD.deltaS.*1.5;
[S0_ALL,putprice] = CEV_last_european(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM,S0(i), StrCallPut);
%S0_ALL=S0_ALL';
%underlying=(dynamics.S0+2*0.1:-FD.deltaS :dynamics.S0-2*0.1)';%
%[ blsCallDelta ,putprice ] = blsprice( underlying , K , r , T ,Sigma );%
%S0_ALL=underlying;%
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
%disp([S0_ALL(indices) putprice(indices)]);
%Part b: calculating the delta and gamma.
putprice_0 = putprice(indices);
DELTA = (putprice_0(1) - putprice_0(3)) ./ (2*FD.deltaS);
%[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,Sigma );
% blsPutDelta
%GAMMA = (putprice_0(1) - (2*putprice_0(2)) + putprice_0(3)) ./ (FD.deltaS^2);
%plot(S0,GAMMA,'r.')
delta_e(i)=DELTA;

 end
plot(S0,delta_e,'g')
hold on


 for i=1:length(S0)
dynamics.S0(i)=S0(i);
displayStart = dynamics.S0(i)-FD.deltaS.*1.5;
displayEnd = dynamics.S0(i)+FD.deltaS.*1.5;
[S0_ALL,putprice] = CEV_last_american(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM,S0(i), StrCallPut);
%S0_ALL=S0_ALL';
%underlying=(dynamics.S0+2*0.1:-FD.deltaS :dynamics.S0-2*0.1)';%
%[ blsCallDelta ,putprice ] = blsprice( underlying , K , r , T ,Sigma );%
%S0_ALL=underlying;%
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
%disp([S0_ALL(indices) putprice(indices)]);
%Part b: calculating the delta and gamma.
putprice_0 = putprice(indices);
DELTA = (putprice_0(1) - putprice_0(3)) ./ (2*FD.deltaS);
%[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,Sigma );
% blsPutDelta
%GAMMA = (putprice_0(1) - (2*putprice_0(2)) + putprice_0(3)) ./ (FD.deltaS^2);
%plot(S0,GAMMA,'r.')
delta_a(i)=DELTA;

end
plot(S0,delta_a,'b')
hold on


for i=1:length(S0)
dynamics.S0(i)=S0(i);
displayStart = dynamics.S0(i)-FD.deltaS.*1.5;
displayEnd = dynamics.S0(i)+FD.deltaS.*1.5;
[S0_ALL,putprice] = CEV_last_bermudan(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM,S0(i), StrCallPut);
%S0_ALL=S0_ALL';
%underlying=(dynamics.S0+2*0.1:-FD.deltaS :dynamics.S0-2*0.1)';%
%[ blsCallDelta ,putprice ] = blsprice( underlying , K , r , T ,Sigma );%
%S0_ALL=underlying;%
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
%disp([S0_ALL(indices) putprice(indices)]);
%Part b: calculating the delta and gamma.
putprice_0 = putprice(indices);
DELTA = (putprice_0(1) - putprice_0(3)) ./ (2*FD.deltaS);
%[ blsCallDelta , blsPutDelta ] = blsdelta( S0 , K , r , T ,Sigma );
% blsPutDelta
%GAMMA = (putprice_0(1) - (2*putprice_0(2)) + putprice_0(3)) ./ (FD.deltaS^2);
%plot(S0,GAMMA,'r.')
delta_b(i)=DELTA;

end 
plot(S0,delta_b,'k')
legend('deltaAsian','deltaEuropean','deltaBermudan','deltaAmerican')
saveas(gcf,'Delta.png')
hold off
toc
 
 