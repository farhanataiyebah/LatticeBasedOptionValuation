Underlying=81:83;
K=100;
r=0.1;
T=0.5;
NumOfTimeSteps=8;
Sigma=0.15;
lambda=sqrt(1.5);
elasticity=1.999;
SgridM=2*NumOfTimeSteps+1;
StrCallPut='Call';


[  S0_ALL  Europeanprices]= European_prices(Underlying, K, r, T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)
a=priceOptionTrinCEVEuropeanTry1(81.1, K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)
b=priceOptionTrinCEVEuropeanTry1(81, K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)
c=priceOptionTrinCEVEuropeanTry1(80.9, K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)

put1=(c-a)/(2*0.1)

e=priceOptionTrinCEVEuropeanTry1(81.9, K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)
f=priceOptionTrinCEVEuropeanTry1(82, K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)
g=priceOptionTrinCEVEuropeanTry1(82.1, K, r,T,NumOfTimeSteps, Sigma,elasticity,lambda,SgridM, StrCallPut)

put2=(e-g)/(2*0.1)






