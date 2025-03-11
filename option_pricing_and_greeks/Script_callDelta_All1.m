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

 Underlying=50:150;
 
 for i=1:length( Underlying)
    %Asian Delta
[ delta_Asian(i) ] = computeDeltaAsian1(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);  
[ delta_European(i) ] = computeDeltaEuropean1(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);  
[ delta_American(i) ] = computeDeltaAmerican1(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);  
[ delta_Bermudan(i) ] = computeDeltaBermudan1(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);  
   
 end
 figure
 plot(Underlying, delta_Asian,'k');
 hold on


 plot(Underlying,delta_European,'r');
 hold on
 
  
blsCall=blsdelta(Underlying,Strike, r, T,Sigma);
plot (Underlying,blsCall,'g')
hold on
 
 
 plot(Underlying,delta_American,'m');
 hold on
 
 plot(Underlying,delta_Bermudan,'b');
 
 legend ('deltaAsian','deltaEuropean','blsdelta','deltaAmerican','deltaBermudan')
 saveas (gcf,'callDelta_All1.png')
 hold off
 toc