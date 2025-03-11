function [ delta] = AuxLatticeDeltaBermudan(Underlying, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;

[~, slat, ~] = priceOptionTrinCEVBermudanTry1(S0, Strike, r, T, ...
               NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);

 k=0;
            for j=NumOfTimeSteps+1:-1:1 %upper nodes
                k=k+1;
                s(k)=slat{j}(1);
                %p(k)=priceOptionTrinCEVAsianTry1(slat{j}(1), Strike, r, T, ...
               %NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
                
            end
            
           k=NumOfTimeSteps+1;
           for j=2:NumOfTimeSteps+1 %lower nodes
               k=k+1;
                s(k)=slat{j}(length(slat{j}(:)));
                %p(k)=priceOptionTrinCEVAsianTry1(slat{j}(length(slat{j}(:))), Strike, r, T, ...
               %NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
                
           end
           
           
           
           delta= (priceOptionTrinCEVBermudanTry1(s(NumOfTimeSteps), Strike, r, T, ...
               NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)-priceOptionTrinCEVBermudanTry1(s(NumOfTimeSteps+2), Strike, r, T, ...
               NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut))/(s(NumOfTimeSteps)-s(NumOfTimeSteps+2));
     
           

 
end