clear;
clc;
tic
alpha = 1.9999;
r = 0.1; 
T = 0.5;
Strike = 95;
NumOfTimeSteps=7;
 Sigma=0.10;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';

 
 Underlying=100;
 
[ newXSamplePoints,smoothedYDelta, smoothedYGamma ] = Interp_AuxLatticeGreeksAmerican(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
            
            figure(1)
            plot(newXSamplePoints,smoothedYDelta,'r')
            title('American Delta')
            
            figure(2)
            plot(newXSamplePoints,smoothedYGamma,'b')
             title('American Gamma')
             
             
            