clear;
clc;
clf;
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=10;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 

 Underlying=80:0.1:120;
 
 for i=1:length( Underlying)
     
 [ delta(i) ] = computeDeltaAsian(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
           
            
 end
 plot(Underlying,delta,'r');
 hold on
 %gamma=diff(delta)./diff(Underlying);
 %plot(Underlying(2:end),gamma,'r');