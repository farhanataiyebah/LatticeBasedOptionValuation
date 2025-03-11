function [ delta2,delta, gamma ] = TrincomputeDeltaAmerican(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;
          %('Call','E',50,50,0.4,0.05,0.02,2,500)

%delta = (p2-p1)/(2*h);
[price, slat, plat] = priceOptionTrinCEVEAmericanTry1(S0, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

cusa12=slat{5}(1);
cusa11=slat{3}(1);
cdsa11=slat{3}(length(slat{3}(:)));
cdsa12=slat{5}(length(slat{5}(:)));
%Delta_usa11=(plat{5}(1)-price)./(cusa12-S0);
%Delta_dsa11=(price-plat{5}(length(slat{5}(:))))./(S0-cdsa12);
delta2=(plat{3}(1)-plat{3}(length(slat{3}(:))))./(cusa11-cdsa11);
%Gamma_S0=(Delta_usa11-Delta_dsa11)./(cusa11-cdsa11);


% Calculate greeks
if nargout > 1
delta = (plat{2}(1)-plat{2}(2))/(slat{2}(1)-slat{2}(2));
end
if nargout > 2
deltaUp = (plat{3}(1)-plat{3}(2))/(slat{3}(1)-slat{3}(2));
deltaDown = (plat{2}(3)-plat{3}(3))/(slat{2}(3)-slat{3}(3));
gamma = (deltaUp-deltaDown)/((slat{3}(1)-slat{3}(3))/2);
end

end