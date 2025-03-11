close all
clc
global T K S q r Option_price
%[data, txt]=xlsread('Chapter11data.xlsx');
[data, txt]=xlsread('chapter6data.xlsx');

T = data(:,1)/365;
K = data(:,2);
Option_price = data(:,3);
fixedspot    = data(:,4);
S = fixedspot;%fixedspot(1)%1050*ones(length(T),1);%
q = (365*data(:,5))/100; %0.02*ones(length(T),1);%0*ones(length(T),1);%%
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
q_51   =  (365*data(19,5))/100 ; % 1.6472e-04;
r_51   =  (365*data(19,6))/100 ; % 1.6500e-04;

St = 600:10:1200 ;
n = length(St);

%%%%%%--------------------------------%%%%%------------------------%%%%%%%

ivol = 0.06 ;
%est_sig = estimated_sigma(ivol);
est_sig =0.25;

s=860:10:900;
for i=1:length(s)
    [ss(i), yy(i), zz(i)] = BS_Approximations(S0,s(i),K1,K3,mp,mc1,mc2,T_51,tau,r_51,q_51, est_sig, Call_1,Call_2);
end



 plot(s,zz-ss,'ko')
 hold off
 clc
 figure(3)
 plot(s,zz-yy,'rd')
 hold off
 





