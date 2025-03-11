function[delta_asian]=put_test_delta_asian(contract,dynamics,FD,elasticty,K,T,Sigma,r,NumOfTimeSteps,lambda,SgridM,M_Bermudan,S0,StrCallPut)
displayStart =dynamics.S0 -FD.deltaS.*1.5;
displayEnd = dynamics.S0+FD.deltaS.*1.5;
[S0_ALL,AsianPut,~,~,~] = Put_test(contract,dynamics,FD,elasticty,K,T,Sigma,r,NumOfTimeSteps,lambda,SgridM,M_Bermudan,S0,StrCallPut);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
asian_0 = AsianPut(indices);
delta_asian = (asian_0(1) - asian_0(3)) ./ (2.*FD.deltaS);
end