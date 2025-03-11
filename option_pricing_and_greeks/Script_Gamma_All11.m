clear;
clc;
tic
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=7;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 M_Bermudan=2;
delta_S=0.001;
 Underlying=50:150;

for i=1:length( Underlying)
[ Gamma_Asian(i) ] = computeGammaAsian11(Underlying(i),delta_S, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_European(i) ] = computeGammaEuropean11(Underlying(i),delta_S, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_American(i) ] = computeGammaAmerican11(Underlying(i),delta_S, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_Bermudan(i) ] = computeGammaBermudan11(Underlying(i),delta_S, Strike, r, T, ...
                NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);            
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
 
 saveas(gcf,'Gamma_All2.png')
 hold off
 %ylim([0 0.05])
 toc