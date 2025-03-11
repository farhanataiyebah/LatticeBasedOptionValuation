function [ delta ] = computeDeltaAmerican(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;

%delta = (p2-p1)/(2*h);
[price, slat, plat] = priceOptionTrinCEVAmericanTry1(S0, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
%delta1=(plat{2}(1)-plat{1}(1))/(slat{2}(1)-slat{1}(1));

cusa12=slat{5}(1);
cusa11=slat{3}(1);
cdsa11=slat{3}(length(slat{3}(:)));
cdsa12=slat{5}(length(slat{5}(:)));



b=priceOptionTrinCEVAmericanTry1(slat{3}(1), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
c=priceOptionTrinCEVAmericanTry1(slat{3}(length(slat{3}(:))), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
%Delta_usa11=(plat{5}(1)-price)./(cusa12-S0);
%Delta_dsa11=(price-plat{5}(length(slat{5}(:))))./(S0-cdsa12);
delta2=(b-c)./(cusa11-cdsa11);

%Delta_usa11=(plat{5}(1)-price)./(cusa12-S0);
%Delta_dsa11=(price-plat{5}(length(slat{5}(:))))./(S0-cdsa12);
%delta=(plat{3}(1)-plat{3}(length(slat{3}(:))))./(cusa11-cdsa11);
%Gamma_S0=(Delta_usa11-Delta_dsa11)./(cusa11-cdsa11);

end