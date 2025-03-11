function[DELTA,GAMMA]=CEVdelta_last(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM,S0, StrCallPut)
%S0=dynamics.S0;
 K=contract.K;
 T=contract.T;
 r=dynamics.r;
displayStart = dynamics.S0-FD.deltaS.*1.5;
displayEnd = dynamics.S0+FD.deltaS.*1.5;
[S0_ALL,putprice] = CEV_last(contract,dynamics,FD,NumOfTimeSteps, Sigma,lambda,SgridM, S0,StrCallPut);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
disp([S0_ALL(indices) putprice(indices)])
%% Part b: calculating the delta and gamma.
putprice_0 = putprice(indices);
DELTA = (putprice_0(1) - putprice_0(3)) ./ (2*FD.deltaS);
GAMMA = (putprice_0(1) - (2*putprice_0(2)) + putprice_0(3)) ./ (FD.deltaS^2);
end