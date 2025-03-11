close all
clc
tic
%global T K S q r Option_price
%[data, txt]=xlsread('Chapter11data.xlsx');
[data, txt]=xlsread('chapter6data.xlsx');
alpha = 1.9999;
NumOfTimeSteps=13;
 %Sigma=0.25;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;

K = data(:,2);
Option_price = data(:,3);
fixedspot    = data(:,4);
S = fixedspot;%fixedspot(1)%1050*ones(length(T),1);%


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
T = data(19,1)/365  ; % 51/365;
tau = 7/365; 
%q_51   =  (365*data(19,5))/100 ; % 1.6472e-04;
r   =  (365*data(19,6))/100 ; % 1.6500e-04;

St = 600:10:1200 ;
n = length(St);

%%%%%%--------------------------------%%%%%------------------------%%%%%%%


Sigma =0.25;

American_del    = zeros(1,n);
American_delgam = zeros(1,n);
American_full   = zeros(1,n);

for i = 1:n 
    [American_del(i), American_delgam(i), American_full(i)] = American_Approximations(S0,St(i),K1,K3,mp,mc1,mc2,T,tau,r,Sigma,NumOfTimeSteps,alpha,lambda,M);



end
figure(1)
plot(St,American_del,'kd')
hold on
plot(St,American_delgam,'k*')
hold on
plot(St,American_full,'k')
grid on

title('American')
ylim([-700, 250]);
xlim([600,1200]);
xlabel('Asset Price')
ylabel('Portfolio Value')
legend('Delta approximation', 'Gamma approximation', 'Full Valuation')
saveas(gca,'American','png')
hold off

toc