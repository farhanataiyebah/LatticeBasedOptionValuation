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
 M_Bermudan=2;

 Underlying=50:0.5:150;
 
 
 for i=1:length( Underlying)
    %Asian Gamma
[ Gamma_Asian(i) ] = computeGammaAsian(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);    
     
    %European Gamma
 [ Gamma_European(i) ] = computeGammaEuropean(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
    %American Gamma      
 [ Gamma_American(i) ] = computeGammaAmerican(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
    %Bermudan Gamma
 [ Gamma_Bermudan(i) ] = computeGammaBermudan(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);
    
            
 end
 figure
 plot(Underlying,Gamma_Asian,'k');
 hold on
 
 
 plot(Underlying,Gamma_European,'r');
 hold on
 
 plot(Underlying,Gamma_American,'g');
 hold on
 
 plot(Underlying,Gamma_Bermudan,'b');
 
 legend('GammaAsian','GammaEuropean','GammaAmerican','GammaBermudan')
 
 saveas(gcf,'computeGamma_All.png')
 hold off
 toc
            