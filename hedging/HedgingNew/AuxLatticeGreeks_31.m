function [ x,delta, gamma ] = AuxLatticeGreeksE_31(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;

[price, slat, plat] = priceOptionTrinCEVEuropeanTry1(S0, Strike, r, T, ...
               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

 k=0;
            for j=NumOfTimeSteps+1:-1:1 %upper nodes
                k=k+1;
                s(k)=slat{j}(1);
                p(k)=priceOptionTrinCEVEuropeanTry1(slat{j}(1), Strike, r, T, ...
               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
                
            end
            
           k=NumOfTimeSteps+1;
           for j=2:NumOfTimeSteps+1 %lower nodes
               k=k+1;
                s(k)=slat{j}(length(slat{j}(:)));
                p(k)=priceOptionTrinCEVEuropeanTry1(slat{j}(length(slat{j}(:))), Strike, r, T, ...
               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
                
           end
     
           
 for i=1:(2*NumOfTimeSteps+1)-4
     delta1=(p(i)-p(i+2))./(s(i)-s(i+2));
     delta(i)=(p(i+1)-p(i+3))./(s(i+1)-s(i+3));
     delta2=(p(i+2)-p(i+4))./(s(i+2)-s(i+4));
     gamma(i)=(delta1-delta2)./(s(i+1)-s(i+3));
     x(i)=s(i+2);
 end
 
end
 
     
     
         
           
           
                   
