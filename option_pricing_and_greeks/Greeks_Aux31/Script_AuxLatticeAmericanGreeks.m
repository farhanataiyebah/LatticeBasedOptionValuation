clear;
clc;
tic
alpha = 1.99999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=8; %Elapsed time is 311.077176 seconds. for 10
                   %Elapsed time is 989.964188 seconds. for 11
 Sigma=0.10;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 %M_Bermudan=2;

 Underlying=100;
 
 [ x,delta, gamma ] = AuxLatticeGreeksAmerican_31(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
%x          
%delta
%gamma

A = [x; delta; gamma];

fileID = fopen('AmericanGreeks.txt','w');
%fprintf(fileID,'%6s %8s %8s\n','Underlying','Delta','Gamma');
fprintf(fileID,'%6.2f %12.8f %12.8f\n',A);
fclose(fileID);


toc