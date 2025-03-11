function [  S0_ALL  Asianprices]= asian_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);

for i=1:length(Underlying)
   Optionprice(i)= priceOptionTrinCEVAsianTry1(Underlying(i), K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
   Asianprices(i)=Optionprice(i);
end
S0_ALL=Underlying;
end