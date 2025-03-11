function [ delta ] = computeDeltaAmerican(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;
h = 10^(-2)*S0; % Won't cause rounding problems
% but a minute change financially
rng('default');
p1 = priceOptionTrinCEVAmericanTry1(S0-h, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
rng('default');
p2 = priceOptionTrinCEVAmericanTry1(S0+h, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
delta = (p2-p1)/(2*h);
end