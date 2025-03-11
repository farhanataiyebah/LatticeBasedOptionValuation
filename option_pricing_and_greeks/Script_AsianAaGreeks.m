clear;
clc;
tic
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=8;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 %M_Bermudan=2;

 Underlying=100;
 
 [ x,delta, gamma ] = AuxLatticeGreeksAsiana_31(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
%x          
%delta
%gamma

A = [x; delta; gamma];

fileID = fopen('AsianAaGreeks.txt','w');
%fprintf(fileID,'%6s %8s %8s\n','Underlying','Delta','Gamma');
fprintf(fileID,'%6.2f %12.8f %12.8f\n',A);
fclose(fileID);

data=load('AsianAaGreeks.txt'); % assuming you only have data values(numbers)
data(:,2) % and jus extract the first column
% or
%data=readtable('AsianAaGreeks.txt'); % requires 2013a or later
%data(:,1) % table with one column which is the first column
%data{:,2} % just numbers in the first column

toc