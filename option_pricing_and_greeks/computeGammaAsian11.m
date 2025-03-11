function [ gamma ] = computeGammaAsian11(Underlying,delta_S, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;

%delta_S=0.01; 
[price1]= priceOptionTrinCEVAsianTry1(S0, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[price2]= priceOptionTrinCEVAsianTry1(S0*(1+delta_S),  Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[price3]= priceOptionTrinCEVAsianTry1(S0*(1-delta_S),  Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
delta1=(price2-price1)/(S0*delta_S);
delta2=(price1-price3)/(S0*delta_S);
gamma=(delta1-delta2)/(S0*delta_S);

end

