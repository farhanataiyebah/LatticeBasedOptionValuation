function [  S0_ALL  Europeanprices]= european_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)

for i=1:length(Underlying)
   Optionprice(i)= priceOptionTrinCEVEuropeanTry1(Underlying(i), K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
   Europeanprices(i)=Optionprice(i);
end
S0_ALL=Underlying;
end