function [ deltax, gammax,delta, gamma ] = TrinGreeks_auxi_Bermudan(Underlying, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)
          S0  = Underlying;

[price, slat, plat] = priceOptionTrinCEVBermudanTry1(S0, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);

 k=0;
            for j=NumOfTimeSteps+1:-1:1 %upper nodes
                k=k+1;
                x(k)=slat{j}(1);
                y(k)=plat{j}(1);
                
            end
            
           k=NumOfTimeSteps+2;
           for j=2:NumOfTimeSteps+1 %lower nodes
               k=k+1;
                x(k)=slat{j}(length(slat{j}(:)));
                y(k)=plat{j}(length(plat{j}(:)));
           end
         
           
           for i=2:2*NumOfTimeSteps+1 %delta
               delta(i-1)=(y(i-1)-y(i))./(x(i-1)-x(i));
               deltax(i-1)=x(i) ;
           end
           
           for i=2:2*NumOfTimeSteps %gamma
               
               gamma(i-1)=(y(i+1)-2.*y(i)+y(i-1))./(x(i)-x(i-1))^2;
               %delta1=(y(i-1)-y(i))./(x(i-1)-x(i));
               %delta2=(y(i+1)-y(i+2))./(x(i+1)-x(i+2));
               
           %gamma(i-1)=(delta1-delta1)./(x(i)-x(i+2));
           gammax(i-1)=x(i);
           end
%x
%%
%for i= 1:2*NumOfTimeSteps+1-4
    %delta(i+1)=(y(i)-y(i+2))./(x(i)-x(i+2));
   % delta(i+2)=(y(i+1)-y(i+3))./(x(i+1)-x(i+3));
  %  delta(i+3)=(y(i+2)-y(i+4))./(x(i+2)-x(i+4));
 %   gamma(i+2)=(delta(i+1)-delta(i+3))./(x(i+1)-x(i+3)); 
    
    %underlying for deltas
    %deltax(i)=x(i+1);
    %deltax(i+1)=x(i+2);
    %deltax(i+2)=x(i+3);
    
    %underlying for gammas
    %gammax(i)=x(i+2);
%end
%deltax=x(1,2:length(x)-1);
%gammax=x(1,3:length(x)-2);
end
           
