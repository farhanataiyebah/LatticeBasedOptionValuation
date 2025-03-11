close all
clc
tic

Rate=0.1;



%%%%%% portfolio initial values %%%%%%%%%%%%%%%%%%%%%%
m1 = -1 ;
m2 = -1.5;
m3 = 2.5 ;
Call_1 =  146.60 ; %in the money
Call_2 =   0.1750;  %out the money
K1 = 1200 ;      %775 ;
K2 = K1;
K3 =  1550  ;        %1125;
S0  = 1338.6;          %917.8
T = 23/365  ; % 51/365;
tau = 7/365; 
St = 1100:10:1700 ;
n = length(St);

Sigma =0.25;

BS_del    = zeros(1,n);
BS_delgam = zeros(1,n);
BS_full   = zeros(1,n);

for i = 1:n 
    [BS_del(i), BS_delgam(i), BS_full(i)] = BS_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,Call_1,Call_2);
end
%Stnew=linspace(min(St),max(St), length(St)*20);
%European_fullnew=spline(St,European_full, Stnew);
%length(St)
%length(BS_del)
figure(1)
plot(St,BS_del,'kd-')
hold on
plot(St,BS_delgam,'k*-')
hold on
plot(St,BS_full,'k','LineWidth',5)
grid on

title('BS')
ylim([-700, 200]);
xlim([1100,1700]);
xlabel('Asset Price')
ylabel('Portfolio Value')
legend('Delta approximation', 'Gamma approximation', 'Full Valuation')
saveas(gca,'BS','png')
hold off
toc