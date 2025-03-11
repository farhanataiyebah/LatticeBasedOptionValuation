function [  S0_ALL  Bermudanprices]= bermudan_prices(Underlying, K, r, T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, StrCallPut);

for i=1:length(Underlying)
   Optionprice(i)= priceOptionTrinCEVBermudanTry1(Underlying(i), K, r,T,NumOfTimeSteps,M_Bermudan, Sigma,elasticity,lambda,SgridM, StrCallPut);
   Bermudanprices(i)=Optionprice(i);
end
S0_ALL=Underlying;
end