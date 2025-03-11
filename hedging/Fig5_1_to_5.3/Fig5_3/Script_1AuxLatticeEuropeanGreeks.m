clear;
clc;
tic
%[data, txt]=xlsread('chapter6data.xlsx');
alpha = 1.9999;
r = 0.1;


T = 23/365  ;
Strike = 1200  ;
NumOfTimeSteps=13;  %Elapsed time is 311.077176 seconds. for 10
                   %Elapsed time is 989.964188 seconds. for 11
 Sigma=0.25;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 %M_Bermudan=2;

 Underlying=1338.6; 
 
 %[ x,delta, gamma ] = AuxLatticeGreeksEuropean_31(Underlying, Strike, r, T, ...
              %  NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
%x          
%delta
%gamma


[x1,delta1, gamma1 ] = AuxLatticeGreeksEuropean_31(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
%x          
%delta
%gamma
[x2,delta2,gamma2]= AuxLatticeGreeksEuropean_31(min(x1), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            k=0;
            for i=1:(2*NumOfTimeSteps+1)-4
            if (x2(i)<min(x1))
                k=k+1;
                x_2(k)=x2(i);
                delta_2(k)=delta2(i);
                gamma_2(k)=gamma2(i);
                
            end
            end
[x3,delta3,gamma3]= AuxLatticeGreeksEuropean_31(max(x1), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut); 
            k=0;
            for i=1:(2*NumOfTimeSteps+1)-4
            if (x3(i)>max(x1))
                k=k+1;
                x_3(k)=x3(i);
                delta_3(k)=delta3(i);
                gamma_3(k)=gamma3(i);
            end
            end
x=[x_3';x1';x_2'];
delta=[delta_3';delta1';delta_2'];
gamma=[gamma_3';gamma1';gamma_2'];

%x
%delta
%gamma



A = [x'; delta'; gamma'];

fileID = fopen('1EuropeanGreeks.txt','w');
%fprintf(fileID,'%6s %8s %8s\n','Underlying','Delta','Gamma');
fprintf(fileID,'%6.2f %12.8f %12.8f\n',A);
%fclose(fileID);


toc