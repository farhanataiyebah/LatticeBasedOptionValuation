function [ delta ] = TrinDeltaAmericanp(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S  = Underlying;

dS=S.*(Sigma.*S.^(alpha/2-1).*sqrt(T));
%delta = (p2-p1)/(2*h);
%[price, slat, plat] = priceOptionTrinCEVEuropeanTry1(S, Strike, r, T, ...
 %               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

delta=((priceOptionTrinCEVAmericanTry1(S+dS, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)-...
                priceOptionTrinCEVAmericanTry1(S, Strike, r, T, ...
               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut))./dS);
end