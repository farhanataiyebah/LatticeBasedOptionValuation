close all
clc
tic
%global T K S Option_price
%[data, txt]=xlsread('Chapter11data.xlsx');
[data, txt]=xlsread('chapter6data.xlsx');

%T = data(:,6)/365;
K = data(:,4);
Option_price = data(:,5);
fixedspot    = data(:,1);
S = fixedspot;%fixedspot(1)%1050*ones(length(T),1);%
%q = (365*data(:,5))/100; %0.02*ones(length(T),1);%0*ones(length(T),1);%%
%r = (365*data(:,6))/100;%0.03*ones(length(T),1);%0.01*ones(length(T),1);%

Rate=0.1;



%%%%%% portfolio initial values %%%%%%%%%%%%%%%%%%%%%%
m1 = -1 ;
m2 = -1.5;
m3 = 2.5 ;
Call_1 =  data(19,3) ; %148.90 ; %in the money
Call_2 =   data(34,3)  ; %0.20 ;  %out the money
K1 = data(19,2) ;      %775 ;
K2 = K1;
K3 =  data(34,2)  ;        %1125;
S0  = data(1,4);          %917.8
T = data(19,1)/365  ; % 51/365;
tau = 7/365; 
alpha = 1.9999;
NumOfTimeSteps=8;
lambda=sqrt(1.5);
M=2*NumOfTimeSteps+1;
 M_Bermudan=2;
St = 600:10:1200 ;
n = length(St);
Sigma =0.25;

Asian_del    = zeros(1,n);
Asian_delgam = zeros(1,n);
Asian_full   = zeros(1,n);

for i = 1:n 
    [Asian_del(i), Asian_delgam(i), Asian_full(i)] = AsianGa_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps, alpha,lambda,M);
end
%Stnew=linspace(min(St),max(St), length(St)*20);
%European_fullnew=spline(St,European_full, Stnew);

figure(1)
plot(St,Asian_del,'rd-')
hold on
plot(St,Asian_delgam,'b*-')
hold on
plot(St,Asian_full,'k')
grid on

title('AsianGa')
%ylim([-700, 250]);
%xlim([2600,3200]);
xlabel('Asset Price')
ylabel('Portfolio Value')
legend('Delta approximation', 'Gamma approximation', 'Full Valuation')
saveas(gca,'AsianGa','png')
hold off
toc




