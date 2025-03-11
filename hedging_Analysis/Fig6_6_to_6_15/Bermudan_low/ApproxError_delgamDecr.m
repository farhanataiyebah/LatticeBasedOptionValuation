%Approximation errors of Greek-based (gamma) valuations decreasing
 
close all
clc
tic
Rate=0.1;
 
 
 
%%%%%% portfolio initial values %%%%%%%%%%%%%%%%%%%%%%
m1 = -1 ;
m2 = -1.5;
m3 = 2.5 ;
%Call_1 =  146.60 ; %in the money
%Call_2 =   17.50 ;   %out the money
K1 = 1200 ;      %775 ;
K2 = K1;
K3 =  1550  ;        %1125;
S0  = 1338.6;          %917.8
T = 23/365  ; % 51/365;
tau = 7/365; 
alpha1 = 1.9999;
alpha2 =1.5;
alpha3 =1;
alpha4 =0.5;
alpha5 =0.05;
NumOfTimeSteps=13;
lambda=sqrt(1.5);
M=2*NumOfTimeSteps+1;
M_Bermudan=2;
 
St = 1250:10:1330 ;
Sigma =10/100;
 
for i = 1:length(St)
    %[~, delta1(i), f1(i)] = BS(S0,St(i),...
       % K1,K3,m1,m2,m3,T,tau,Rate,Sigma);
    [~, g2(i), f2(i)] = Bermudan_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,M_Bermudan,alpha1,lambda,M);
    [~, g3(i), f3(i)] = Bermudan_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,M_Bermudan,alpha2,lambda,M);
    [~, g4(i), f4(i)] = Bermudan_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,M_Bermudan,alpha3,lambda,M);
    [~, g5(i), f5(i)] =Bermudan_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,M_Bermudan, alpha4,lambda,M);
    [~, g6(i), f6(i)] = Bermudan_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,M_Bermudan, alpha5,lambda,M);
end
%range=1340:10:1440;
%err_BS=(f1-delta1);
err_A1=(f2-g2);
err_A2=(f3-g3);
err_A3=(f4-g4);
err_A4=(f5-g5);
err_A5=(f6-g6);

 figure(1)
 
plot(St, err_A1,'kp-')
hold on

plot(St, err_A2,'rd-')
hold on

plot(St, err_A3,'bs-')
hold on

%plot(St, err_BS,'ks-')
%hold on
 
plot(St, err_A4,'m*-')
hold on
 
plot(St, err_A5,'g>-')
 
title(' Approximation error(Decreasing)for low market volatility 10% ')
%ylim([6.15, 6.65]);
xlim([1240,1340]);
xlabel('Asset')
ylabel('Full Valuation-Gamma Approximation')
legend('alpha=1.9999','alpha=1.5','alpha=1' ,'alpha=0.5','alpha=0.05')
%saveas(gca,'delgamErr_Decr','png')
 
 
hold off
 
 
 
 
 
toc

