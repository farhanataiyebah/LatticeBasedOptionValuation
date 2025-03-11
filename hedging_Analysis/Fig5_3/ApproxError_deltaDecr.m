%Approximation errors of Greek-based (delta) valuations decreasing
 
close all
clc
tic
Rate=0.1;
 
 
 
%%%%%% portfolio initial values %%%%%%%%%%%%%%%%%%%%%%
m1 = -1 ;
m2 = -1.5;
m3 = 2.5 ;
Call_1 =  146.60 ; %in the money
Call_2 =   17.50 ;   %out the money
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
 
St = 1250:10:1330 ;
n = length(St);
Sigma =0.25;
 
for i = 1:n 
    
    [European_del(i), European_delgam(i), European_full(i)] = European_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M);
    [Bermudan_del(i), Bermudan_delgam(i), Bermudan_full(i)] = Bermudan_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, M_Bermudan,alpha,lambda,M);
    [American_del(i), American_delgam(i), American_full(i)] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M);
    [Asiana_del(i), Asiana_delgam(i), Asiana_full(i)] = AsianAa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha,lambda,M);
    [Asiang_del(i), Asiang_delgam(i), Asiang_full(i)] = AsianGa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha,lambda,M);
end
%range=1340:10:1440;
figure(1)
 

err_European=(European_full-European_del);
err_Bermudan=(Bermudan_full-Bermudan_del);
err_American=(American_full-American_del);
err_AsianAa=(Asiana_full-Asiana_del);
err_AsianGa=(Asiang_full-Asiang_del);

 
 
plot(St, err_American,'kp-')
hold on

plot(St, err_Bermudan,'kd-')
hold on

plot(St,err_European,'ko-')
hold on
 

 
plot(St, err_AsianAa,'k*-')
hold on
 
plot(St, err_AsianGa,'k>-')
grid on
 
title(' Approximation error(Decreasing) ')
ylim([-4, 16]);
xlim([1240,1340]);
xlabel('Asset')
ylabel('Full Valuation-Delta Approximation')
legend('American','Bermudan','European','AsianAa','AsianGa')
 
 
hold off
 
 
 
 
 
toc

