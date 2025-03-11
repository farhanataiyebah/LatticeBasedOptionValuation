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

St = 1100:10:1700 ;
n = length(St);
Sigma =0.25;

Asian_del    = zeros(1,n);
Asian_delgam = zeros(1,n);
Asian_full   = zeros(1,n);

for i = 1:n 
    [Asian_del(i), Asian_delgam(i), Asian_full(i)] = AsianAa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha,lambda,M);
end
%Stnew=linspace(min(St),max(St), length(St)*20);
%European_fullnew=spline(St,European_full, Stnew);

figure(1)
plot(St,Asian_del,'kd-')
hold on
plot(St,Asian_delgam,'k*-')
hold on
plot(St,Asian_full,'k','LineWidth',4)
grid on

title('Asian Arithmatic')
ylim([-700, 200]);
xlim([1100,1700]);
xlabel('Asset Price')
ylabel('Portfolio Value')
legend('Delta approximation', 'Gamma approximation', 'Full Valuation')
saveas(gca,'Asian','png')
hold off
toc




