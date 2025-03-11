%Approximation errors of Greek-based (delta) valuations increasing

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
%M_Bermudan=2;
St = 1350:10:1430 ;
n = length(St);
Sigma =10/100;
 
for i = 1:length(St)
    %[~, delta1(i), f1(i)] = BS(S0,St(i),...
       % K1,K3,m1,m2,m3,T,tau,Rate,Sigma);
    [d2(i), ~, f2(i)] = AsianGa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha1,lambda,M);
    [d3(i), ~, f3(i)] = AsianGa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha2,lambda,M);
    [d4(i), ~, f4(i)] =AsianGa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha3,lambda,M);
    [d5(i), ~, f5(i)] =AsianGa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha4,lambda,M);
    [d6(i), ~, f6(i)] = AsianGa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha5,lambda,M);
end
%range=1340:10:1440;
%err_BS=(f1-delta1);
er_A1=(f2-d2);
er_A2=(f3-d3);
er_A3=(f4-d4);
er_A4=(f5-d5);
er_A5=(f6-d6);

figure(1)
 
plot(St, er_A1,'kp-')
hold on

plot(St, er_A2,'rd-')
hold on

plot(St, er_A3,'bs-')
hold on

%plot(St, err_BS,'ks-')
%hold on
 
plot(St, er_A4,'m*-')
hold on
 
plot(St, er_A5,'g>-')
 
 
title(' Approximation error(Increasing)for low market volatility 10% ')
%ylim([-4, 16]);
xlim([1340,1440]);
xlabel('Asset')
ylabel('Full Valuation-delta Approximation')
legend('alpha=1.9999','alpha=1.5','alpha=1' ,'alpha=0.5','alpha=0.05')
%saveas(gca,'delgamErr_Incr','png')
 
 
hold off
 
 
 
 
 
toc
