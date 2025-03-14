function [ gamma ] = TrinGammaBermudanp(Underlying, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)
          S  = Underlying;

dS=S.*(Sigma.*S.^(alpha/2-1).*sqrt(T));

gamma=((priceOptionTrinCEVBermudanTry1(S+dS, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)-...
                2.*priceOptionTrinCEVBermudanTry1(S, Strike, r, T, ...
               NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)...
              + priceOptionTrinCEVBermudanTry1(S-dS, Strike, r, T, ...
               NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut))./(dS^2));

end