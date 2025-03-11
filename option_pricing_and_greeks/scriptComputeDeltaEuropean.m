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

 Underlying=50:150;
 
 for i=1:length( Underlying)
    %Asian Delta
[ delta1(i), delta2(i), delta3(i) ] = computeDeltaEuropean(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);  
   
 end
 figure
 plot(Underlying,delta1,'k');
 hold on
 
blsprice=blsdelta(Underlying,Strike, r, T,Sigma);
plot (Underlying,blsprice,'g')
hold on

 plot(Underlying,delta2,'r');
 hold on
 
 plot(Underlying,delta3,'m');
 
 legend ('delta1','delta2','blsprice','delta3')
 
 hold off