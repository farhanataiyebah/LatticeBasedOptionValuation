function [ Gamma ] = computeGammaAsian1(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;
[price, slat, plat] = priceOptionTrinCEVAsianTry1(S0, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
%delta1=(plat{2}(1)-plat{1}(1))/(slat{2}(1)-slat{1}(1));

cusa12=slat{5}(1);
cusa11=slat{3}(1);
cdsa11=slat{3}(length(slat{3}(:)));
cdsa12=slat{5}(length(slat{5}(:)));
Delta_usa11=(priceOptionTrinCEVAsianTry1(slat{5}(1), Strike, r, T, ...
            NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)-...
            price)./(slat{5}(1)-S0);
         
         
Delta_dsa11=(price-...
            priceOptionTrinCEVAsianTry1(slat{5}(length(slat{5}(:))), Strike, r, T, ...
             NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut))./(S0-slat{5}(length(slat{5}(:))));        
         
%Delta_usa11=(plat{5}(1)-price)./(cusa12-S0);
%Delta_dsa11=(price-plat{5}(length(slat{5}(:))))./(S0-cdsa12);
%delta2=(plat{3}(1)-plat{3}(length(slat{3}(:)))./(cusa11-cdsa11);
Gamma=(Delta_usa11-Delta_dsa11)./(cusa11-cdsa11);
 


end