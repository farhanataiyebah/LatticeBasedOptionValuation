clear;
clc;
tic
alpha = 1.99999;
r = 0.01;

T = 0.5;
Strike = 95;
NumOfTimeSteps=8;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
M_Bermudan=2; 

 Underlying=60:10:130;
 
 for i=1:length( Underlying)
    %i=5 

[ Gamma_Asian(i) ] = TrinGammaAsianp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut) ;
            
[ Gamma_European(i) ] = TrinGammaEuropeanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
[ Gamma_Bermudan(i)] = TrinGammaBermudanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)  ;
            
[ Gamma_American(i) ] = TrinGammaAmericanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)  ;          
 end
 Gamma_bls = blsgamma(Underlying, Strike, r, T,Sigma);
 figure
 plot(Underlying,Gamma_Asian,'k');
 hold on
 
 
 plot(Underlying,Gamma_European,'b');
 hold on
 
 plot(Underlying, Gamma_bls,'r');
 hold on
 
 plot(Underlying,Gamma_Bermudan,'g');
 hold on
 
 plot(Underlying,Gamma_American,'m');
 
 legend('gammaAsian','gammaEuropean','gammabls','gammaBermudan','gammaAmerican')
 
 saveas(gcf,'TrinGammap_All.png')
 hold off
 toc