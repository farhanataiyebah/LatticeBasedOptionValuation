
close all
clc
tic

Rate=0.1;


format short
%%%%%% portfolio initial values %%%%%%%%%%%%%%%%%%%%%%
m1 = -1 ;
m2 = -1.5;
m3 = 2.5 ;

K1 = 1200 ;      %775 ;
K2 = K1;
K3 =  1550  ;        %1125;
S0  = 1338.6;          %917.8
T = 23/365  ; % 51/365;
tau = 7/365; 
alpha = 1.9999;
NumOfTimeSteps=13;
lambda=sqrt(1.5);
M=2*NumOfTimeSteps+1;
M_Bermudan=2;
St = 1100:10:1700 ;
n = length(St);
Sigma =0.25;
Call_1=priceOptionTrinCEVBermudanTry1(S0, K1, Rate,T, ...
               NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, 'Call')
put=priceOptionTrinCEVBermudanTry1(S0, K1, Rate,T, ...
               NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, 'Put')
            
Call_2=priceOptionTrinCEVBermudanTry1(S0, K3, Rate,T, ...
              NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, 'Call')