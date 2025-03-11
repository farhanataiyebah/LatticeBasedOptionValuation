clear;
clc;
tic
alpha = 1.999;
r = 0.1;
S0=100;
T = 0.5;
Strike = 95;
NumOfTimeSteps=7;
 Sigma=0.30;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';

 [price, slat, plat] = priceOptionTrinCEVAmericanTry1(S0, Strike, r, T, ...
               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

 k=0;
            for j=NumOfTimeSteps+1:-1:1 %upper nodes
                k=k+1;
                s(k)=slat{j}(1);
             
            end
            
           k=NumOfTimeSteps+1;
           for j=2:NumOfTimeSteps+1 %lower nodes
               k=k+1;
                s(k)=slat{j}(length(slat{j}(:)));
               
                
                
           end          % min(slat)
           format short
           
           max(s)
           min(s)