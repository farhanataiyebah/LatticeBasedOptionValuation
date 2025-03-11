%Approximation errors of Greek-based (delta) valuations decreasing
 
close all
clc
tic
Rate=0.1;
 
 
 
%%%%%% portfolio initial values %%%%%%%%%%%%%%%%%%%%%%
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
%M_Bermudan=2;
 
St = 1250:10:1330 ;
Sigma =10/100;
 
for i = 1:length(St)
    %[~, delta1(i), f1(i)] = BS(S0,St(i),...
       % K1,K3,m1,m2,m3,T,tau,Rate,Sigma);
    [dd2(i), ~, fv2(i)] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha1,lambda,M);
    [dd3(i), ~, fv3(i)] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha2,lambda,M);
    [dd4(i), ~, fv4(i)] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha3,lambda,M);
    [dd5(i), ~, fv5(i)] =American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha4,lambda,M);
    [dd6(i), ~, fv6(i)] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha5,lambda,M);
end
%range=1340:10:1440;
%err_BS=(f1-delta1);
e_A1=(fv2-dd2);
e_A2=(fv3-dd3);
e_A3=(fv4-dd4);
e_A4=(fv5-dd5);
e_A5=(fv6-dd6);

 figure(1)
 
plot(St, e_A1,'kp-')
hold on

plot(St, e_A2,'rd-')
hold on

plot(St, e_A3,'bs-')
hold on

%plot(St, err_BS,'ks-')
%hold on
 
plot(St, e_A4,'m*-')
hold on
 
plot(St, e_A5,'g>-')
 
title(' Approximation error(Decreasing)for low market volatility 10% ')
%ylim([-4, 16]);
xlim([1240,1340]);
xlabel('Asset')
ylabel('Full Valuation-Delta Approximation')
legend('alpha=1.9999','alpha=1.5','alpha=1' ,'alpha=0.5','alpha=0.05')
%saveas(gca,'deltaErr_Decr','png')
 
 
hold off
 
 
 
 
 
toc

