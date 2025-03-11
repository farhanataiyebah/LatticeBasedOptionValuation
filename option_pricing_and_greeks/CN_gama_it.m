function[gama_it]=CN_gama_it(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0)

displayStart =dynamics.S0 -FD.deltaS.*1.5;
displayEnd = dynamics.S0+FD.deltaS.*1.5;
[S0_ALL,delta_it,~] = CEV(contract,dynamics,FD,beta,X,T,t,sigma0,r,q,S0);
indices = (S0_ALL > displayStart & S0_ALL < displayEnd);
delta_it_0 = delta_it(indices);
gama_it = (delta_it_0(1) - delta_it_0(3)) ./ (2.*FD.deltaS);
end

