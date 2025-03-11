clear;
clc;
tic
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=8;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
M_Bermudan=3; 

 Underlying=50:200;
 
 for i=1:length( Underlying)
    %i=5 
 [delta1_Asian(i), delta_Asian(i), gamma_Asian(i) ] =  TrincomputeGreeksAsian(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
 [delta1_European(i), delta_European(i), gamma_European(i) ] =  TrincomputeGreeksEuropean(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
 [delta1_Bermudan(i), delta_Bermudan(i), gamma_Bermudan(i) ] =  TrincomputeGreeksBermudan(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);
            
 [delta1_American(i), delta_American(i), gamma_American(i) ] =  TrincomputeGreeksAmerican(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
 end
 gamma_bls = blsgamma(Underlying, Strike, r, T,Sigma);
 figure
 plot(Underlying,gamma_Asian,'k');
 hold on
 
 
 plot(Underlying,gamma_European,'b');
 hold on
 
 plot(Underlying,gamma_bls,'r');
 hold on
 
 plot(Underlying,gamma_Bermudan,'g');
 hold on
 
 plot(Underlying,gamma_American,'m');
 
 legend('gammaAsian','gammaEuropean','gammaBls','gammaBermudan','gammaAmerican')
 
 saveas(gcf,'TrincomputeGamma_All.png')
 hold off
 toc