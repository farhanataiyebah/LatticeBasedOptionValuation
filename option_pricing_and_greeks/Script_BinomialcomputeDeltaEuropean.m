clear;
clc;
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
 

 Underlying=50:500;
 
 for i=1:length( Underlying)
    %i=5 
 [delta1(i), delta(i), gamma(i) ] =  BinomialcomputeDeltaEuropean(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
 end
% figure
 %plot(Underlying,delta1,'r');
 %hold on
 
 %plot(Underlying,delta,'r');
 %legend('delta1','delta2')
 %saveas(gcf,'Delta1andDelta2.png')
 %hold off
 
 figure
 plot(Underlying,gamma,'r');
 