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
NumOfTimeSteps=8; %Elapsed time is 2904.605417 seconds.
lambda=sqrt(1.5);
M=2*NumOfTimeSteps+1;

St = 1100:10:1700 ;
n = length(St);
Sigma =0.25;

American_del    = zeros(1,n);
American_delgam = zeros(1,n);
American_full   = zeros(1,n);

 type1='nearest';
  type2='linear';
   type3='spline';
    type4='pchip';
     type5= 'cubic';
      type6='v5cubic';
      

for i = 1:n 
    [American_del1(i), American_delgam1(i), American_full(i)] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M,type1);
    
    [American_del2(i), American_delgam2(i), ~] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M,type2);
        
    [American_del3(i), American_delgam3(i), ~] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M,type3);
        
    [American_del4(i), American_delgam4(i), ~] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M,type4);
        
    [American_del5(i), American_delgam5(i), ~] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M,type5);
        
    [American_del6(i), American_delgam6(i), ~] = American_Approximations(S0,St(i),...
        K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M,type6);
    
    
end
%Stnew=linspace(min(St),max(St), length(St)*20);
%European_fullnew=spline(St,European_full, Stnew);

figure(1)
plot(St,American_del1,'Color',[0.2 0.6 0.4])
hold on
plot(St,American_del2,'Color',[1 0.7 0.5])
hold on
plot(St,American_del3,'Color',[0.2 0.6 1])
hold on

plot(St,American_del4,'Color',[0.2 1 0.4])
hold on

plot(St,American_del5,'Color',[1 0.9 0.4])
hold on

plot(St,American_del6,'Color',[1 0.6 1])
hold on

plot(St,American_full,'k','LineWidth',4)

grid on

title('American Delta Approximation')
ylim([-700, 200]);
xlim([1100,1700]);
xlabel('Asset Price')
ylabel('Portfolio Value')
legend('nearest', 'linear', 'spline','pchip','cubic','v5cubic')
saveas(gca,'American_delAppx','jpg')
hold off



figure(2)
plot(St,American_delgam1,'Color',[0.2 0.6 0.4])
hold on
plot(St,American_delgam2,'Color',[1 0.7 0.5])
hold on
plot(St,American_delgam3,'Color',[0.2 0.6 1])
hold on

plot(St,American_delgam4,'Color',[0.2 1 0.4])
hold on

plot(St,American_delgam5,'Color',[1 0.9 0.4])
hold on

plot(St,American_delgam6,'Color',[1 0.6 1])
hold on

plot(St,American_full,'k','LineWidth',4)

grid on


grid on

title('American Delta-Gamma Approximation')
ylim([-700, 200]);
xlim([1100,1700]);
xlabel('Asset Price')
ylabel('Portfolio Value')
legend('nearest', 'linear', 'spline','pchip','cubic','v5cubic')
saveas(gca,'American_delgamAppx','jpg')
hold off
toc




