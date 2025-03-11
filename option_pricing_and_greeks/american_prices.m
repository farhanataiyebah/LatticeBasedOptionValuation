function [  S0_ALL  Americanprices]= american_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
format long
for i=1:length(Underlying)
   Optionprice(i)= priceOptionTrinCEVAmericanTry1(Underlying(i), K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
   Americanprices(i)=Optionprice(i);
end
S0_ALL=Underlying;
end