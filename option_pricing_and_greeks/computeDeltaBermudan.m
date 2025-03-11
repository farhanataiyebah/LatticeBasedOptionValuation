function [ delta ] = computeDeltaBermudan(Underlying, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;

%delta = (p2-p1)/(2*h);
[price, slat, plat] = priceOptionTrinCEVBermudanTry1(S0, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);
cusa12=slat{5}(1);
cusa11=slat{3}(1);
cdsa11=slat{3}(length(slat{3}(:)));
cdsa12=slat{5}(length(slat{5}(:)));

%Delta_usa11=(plat{5}(1)-price)./(cusa12-S0);
%Delta_dsa11=(price-plat{5}(length(slat{5}(:))))./(S0-cdsa12);
delta=(plat{3}(1)-plat{3}(length(slat{3}(:))))./(cusa11-cdsa11);
%Gamma_S0=(Delta_usa11-Delta_dsa11)./(cusa11-cdsa11);

end