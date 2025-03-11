close all
clc
tic
%global T K S q r Option_price
%[data, txt]=xlsread('Chapter11data.xlsx');
[data, txt]=xlsread('chapter6data.xlsx');
alpha = 1.999;
NumOfTimeSteps=7;
 Sigma=0.25;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
T = data(:,1)/365;
K = data(:,2);
Option_price = data(:,3);
fixedspot    = data(:,4);
S = fixedspot;%fixedspot(1)%1050*ones(length(T),1);%
%q = (365*data(:,5))/100; %0.02*ones(length(T),1);%0*ones(length(T),1);%%
r = (365*data(:,6))/100;%0.03*ones(length(T),1);%0.01*ones(length(T),1);%


%%%%%% portfolio initial values %%%%%%%%%%%%%%%%%%%%%%
mp = -1 ;
mc1 = -1.5;
mc2 = 2.5 ;
Call_1 =  data(19,3)  ;%148.90 ;
Call_2 =   data(34,3)  ; %0.20 ;
K1 = data(19,2) ;        %775 ;
K2 = K1;
K3 =  data(34,2)  ;        %1125;
S0  = data(1,4);          %917.8
T_51 = data(19,1)/365  ; % 51/365;
tau = 7/365; 
%q_51   =  (365*data(19,5))/100 ; % 1.6472e-04;
r_51   =  (365*data(19,6))/100 ; % 1.6500e-04;

St = 600:10:1200 ;
n = length(St);

%%%%%%--------------------------------%%%%%------------------------%%%%%%%

%ivol = 0.06 ;
%est_sig = estimated_sigma(ivol);
est_sig =0.25;

Asian_del    = zeros(1,n);
Asian_delgam = zeros(1,n);
Asian_full   = zeros(1,n);

for i = 1:n 
    [Asian_del(i), Asian_delgam(i), Asian_full(i)] = Asian_Approximations(S0,St(i),K1,K3,mp,mc1,mc2,T_51,tau,r_51,est_sig,Call_1,Call_2,NumOfTimeSteps,alpha,lambda,M);


end
figure(1)
plot(St,Asian_del,'kd')
hold on
plot(St,Asian_delgam,'k*')
hold on
plot(St,Asian_full,'k')
grid on

title('Asian')
ylim([-700, 250]);
xlim([600,1200]);
xlabel('Asset Price')
ylabel('Portfolio Value')
legend('Delta approximation', 'Gamma approximation', 'Full Valuation')
saveas(gca,'Asian','png')
hold off

toc



