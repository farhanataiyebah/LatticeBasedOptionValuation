function [ Gamma ] = computeGammaAsian(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
  
            S0  = Underlying;
            h=0.05;
p1=computeDeltaAsian(S0-h, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

            
p2=computeDeltaAsian(S0+h, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

Gamma=(p2-p1)./(2*h);
end