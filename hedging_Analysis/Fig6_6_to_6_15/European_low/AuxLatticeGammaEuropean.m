function [ gamma] = AuxLatticeGammaEuropean(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;

[price, slat, plat] = priceOptionTrinCEVEuropeanTry1(S0, Strike, r, T, ...
               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

 k=0;
            for j=NumOfTimeSteps+1:-1:1 %upper nodes
                k=k+1;
                s(k)=slat{j}(1);
               % p(k)=priceOptionTrinCEVAsianTry1(slat{j}(1), Strike, r, T, ...
               %NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
                
            end
            
           k=NumOfTimeSteps+1;
           for j=2:NumOfTimeSteps+1 %lower nodes
               k=k+1;
                s(k)=slat{j}(length(slat{j}(:)));
                %p(k)=priceOptionTrinCEVAsianTry1(slat{j}(length(slat{j}(:))), Strike, r, T, ...
               %NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
                
           end
           
           
           
           gamma= (AuxLatticeDeltaEuropean(s(NumOfTimeSteps), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)-AuxLatticeDeltaEuropean(s(NumOfTimeSteps+2), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut))/(s(NumOfTimeSteps)-s(NumOfTimeSteps+2));
     
           

 
end