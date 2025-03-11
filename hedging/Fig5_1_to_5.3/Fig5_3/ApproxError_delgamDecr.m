%Approximation errors of Greek-based (gamma) valuations decreasing
 
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
NumOfTimeSteps=8;
lambda=sqrt(1.5);
M=2*NumOfTimeSteps+1;
M_Bermudan=2;
 
St = 1250:10:1330 ;
Sigma =0.25;
 
for i = 1:length(St)
    [BS_del(i), BS_delgam(i), BS_full(i)] = BS(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma);
    [European_del(i), European_delgam(i), European_full(i)] = European_Approximations1(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M);
    [Bermudan_del(i), Bermudan_delgam(i), Bermudan_full(i)] = Bermudan_Approximations1(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, M_Bermudan,alpha,lambda,M);
    [American_del(i), American_delgam(i), American_full(i)] = American_Approximations1(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M);
    [Asian_del(i), Asian_delgam(i), Asian_full(i)] = AsianAa_Approximations1(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha,lambda,M);
    [Asiang_del(i), Asiang_delgam(i), Asiang_full(i)] = AsianGa_Approximations1(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha,lambda,M);
end
%range=1340:10:1440;
err_BS=(BS_full-BS_delgam);
err_European=(European_full-European_delgam);
err_Bermudan=(Bermudan_full-Bermudan_delgam);
err_American=(American_full-American_delgam);
err_AsianAa=(Asian_full-Asian_delgam);
err_AsianGa=(Asiang_full-Asiang_delgam);

 figure(1)
plot(St, err_BS,'ks-')
hold on
 
plot(St,err_European,'ko-')
hold on
 
plot(St, err_Bermudan,'kd-')
hold on
 
plot(St, err_American,'kp-')
hold on
 
plot(St, err_AsianAa,'k*-')
hold on
 
plot(St, err_AsianGa,'k>-')
 
title(' Approximation error(Decreasing) ')
ylim([0, 14]);
xlim([1240,1340]);
xlabel('Asset')
ylabel('Full Valuation-Gamma Approximation')
legend('BS' ,'European','Bermudan','American','Asian Arithmetic','Asian Geometric')
%saveas(gca,'delgamErr_Decr','png')
 
 
hold off
 
 
 
 
 
toc

