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

 Underlying=50:220;
 
 for i=1:length( Underlying)
    %Asian Delta
[ delta_Asian(i) ] = computeDeltaAsian(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);    
     
    %European Delta
 [delta1(i), delta_European(i) ] = computeDeltaEuropean(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
    %American Delta      
 [ delta_American(i) ] = computeDeltaAmerican(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
    %Bermudan Delta
 [ delta_Bermudan(i) ] = computeDeltaBermudan(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);
    
            
 end
 figure
 plot(Underlying,delta_Asian,'k');
 hold on
 
 
 plot(Underlying,delta_European,'r');
 hold on
 
 plot(Underlying,delta_American,'g');
 hold on
 
 plot(Underlying,delta_Bermudan,'b');
 
 legend('deltaAsian','deltaEuropean','deltaAmerican','deltaBermudan')
 
 saveas(gcf,'computeDelta_All.png')
 hold off
 toc
 