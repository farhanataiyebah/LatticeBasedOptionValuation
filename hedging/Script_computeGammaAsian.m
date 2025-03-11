clear;
clc;
clf;
tic
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=7;
 Sigma=0.25;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 

 Underlying=70:0.1:120;
 
 for i=1:length( Underlying)
     
 [ gamma(i) ] = computeGammaAsian(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
           
            
 end
 plot(Underlying,gamma,'r');
 saveas(gcf,'Gamma_asian.png')
 toc