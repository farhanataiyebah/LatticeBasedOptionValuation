clear;
clc;
tic
alpha = 1.99999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=8; %2023.883537 secons
 Sigma=0.10;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
M_Bermudan=2; 

 Underlying=50:150;
 
 for i=1:length( Underlying)
    %i=5 

[ delta_Asian(i) ] = TrinDeltaAsianp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut) ;
            
            
[ delta_AsianG(i) ] = TrinDeltaAsianGp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut) ;
            
[ delta_European(i) ] = TrinDeltaEuropeanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
[ delta_Bermudan(i)] = TrinDeltaBermudanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)  ;
            
[ delta_American(i) ] = TrinDeltaAmericanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)  ;          
 end
 [CallDelta, PutDelta] = blsdelta(Underlying, Strike, r, T,Sigma);
 figure
 plot(Underlying,delta_Asian,'k');
 hold on
 
  plot(Underlying,delta_AsianG,'Color',[1 0.5 0]);
 hold on
 
 
 plot(Underlying,delta_European,'b');
 hold on
 
 plot(Underlying,CallDelta,'r');
 hold on
 
 plot(Underlying,delta_Bermudan,'g');
 hold on
 
 plot(Underlying,delta_American,'m');
 
 title(' Call Delta (Ordinary Lattice) ')
 
 legend('Asian Arithmetic','Asian Geometric','European','BLS','Bermudan','American')
 xlabel('Underlying')
 ylabel('Delta')
 
 saveas(gcf,'TrinDeltap_All.png')
 hold off
 toc
 