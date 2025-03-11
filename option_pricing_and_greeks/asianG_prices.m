function [  S0_ALL  asianGprices]= asianG_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)

for i=1:length(Underlying)
   Optionprice(i)= priceOptionTrinCEVAsianGTry1(Underlying(i), K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut);
   asianGprices(i)=Optionprice(i);
end
S0_ALL=Underlying;
end