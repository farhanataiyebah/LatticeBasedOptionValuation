function [ Gamma ] = GammaAmerican1_dS(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;
[price, slat, plat] = priceOptionTrinCEVEuropeanTry1(S0, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
%delta1=(plat{2}(1)-plat{1}(1))/(slat{2}(1)-slat{1}(1));
dS=S0.*(Sigma.*S0.^(alpha/2-1).*sqrt(T));

%usa12=slat{5}(1);
%usa11=slat{3}(1);
%dsa11=slat{3}(length(slat{3}(:)));
%dsa12=slat{5}(length(slat{5}(:)));
Delta_usa11=(priceOptionTrinCEVEuropeanTry1(S0+2*dS, Strike, r, T, ...
            NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)-...
            price)./(2*dS);
         
         
Delta_dsa11=(price-...
            priceOptionTrinCEVEuropeanTry1(S0-2*dS, Strike, r, T, ...
             NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)./(2*dS));        
         
%Delta_usa11=(plat{5}(1)-price)./(cusa12-S0);
%Delta_dsa11=(price-plat{5}(length(slat{5}(:))))./(S0-cdsa12);
%delta2=(plat{3}(1)-plat{3}(length(slat{3}(:)))./(cusa11-cdsa11);
Gamma=(Delta_usa11-Delta_dsa11)./(2*dS);


end