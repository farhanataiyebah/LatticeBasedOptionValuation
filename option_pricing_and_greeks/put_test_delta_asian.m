function[delta_asian delta_European delta_Bermudan delta_American]=put_test_delta_asian(contract,dynamics,FD,elasticity,K,T,Sigma,r,NumOfTimeSteps,lambda,SgridM,M_Bermudan,S0,StrCallPut)
volcoeff = dynamics.volcoeff;
elasticity = dynamics.alpha;
r = dynamics.r;
T = contract.T;
K = contract.K;
% SMin and SMax denote the smallest and largest values of the underlying S.
% The boundary conditions are imposed one step beyond, e.g. at
% S_lowboundary = SMin - deltaS, not at SMin.
SMax = FD.SMax;
SMin = FD.SMin;
deltaS = FD.deltaS;
deltat = FD.deltat;
%S0=dynamics.S0;
%S = (dynamics.S0+2*deltaS:-deltaS:dynamics.S0-2*deltaS)'; % This has to be a column vector.
%S_lowboundary = SMin - deltaS;
displayStart =dynamics.S0 -FD.deltaS.*1.5;
displayEnd = dynamics.S0+FD.deltaS.*1.5;
[S0_ALL,AsianPut,EuropeanPut,BermudanPut,AmericanPut] = Put_test(contract,dynamics,FD,elasticity,K,T,Sigma,r,NumOfTimeSteps,lambda,SgridM,M_Bermudan,S0,StrCallPut);
%S0_ALL=S' ;
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
asian_0 = AsianPut(indices);
European_0 = EuropeanPut(indices);
Bermudan_0 =BermudanPut(indices);
American_0 = AmericanPut(indices);


delta_asian = (asian_0(1) - asian_0(3)) ./ (2.*FD.deltaS);
delta_European = (European_0(1) - European_0(3)) ./ (2.*FD.deltaS);
delta_Bermudan = (Bermudan_0(1) - Bermudan_0(3)) ./ (2.*FD.deltaS);
delta_American = (American_0(1) - American_0(3)) ./ (2.*FD.deltaS);
end