function [ gamma ] = computeGammaEuropean(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;
h = 10^(-2)*S0; % Won't cause rounding problems
% but a minute change financially
rng('default');
d1 = computeDeltaEuropean(S0-h, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
rng('default');
d2 = computeDeltaEuropean(S0+h, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
gamma = (d2-d1)/(2*h);
end