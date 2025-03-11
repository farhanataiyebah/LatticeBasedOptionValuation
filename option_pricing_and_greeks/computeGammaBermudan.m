function [ Gamma ] = computeDeltaBermudan(Underlying, Strike, r, T, ...
                NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);
          S0  = Underlying;
%[price, slat, plat] = priceOptionTrinCEVBermudanTry1(S0, Strike, r, T, ...
                %NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);
%delta1=(plat{2}(1)-plat{1}(1))/(slat{2}(1)-slat{1}(1));

%cusa12=slat{5}(1);
%cusa11=slat{3}(1);
%cdsa11=slat{3}(length(slat{3}(:)));
%cdsa12=slat{5}(length(slat{5}(:)));

%Delta_usa11=(plat{5}(1)-price)./(cusa12-S0);
%Delta_dsa11=(price-plat{5}(length(slat{5}(:))))./(S0-cdsa12);
%delta2=(plat{3}(1)-plat{3}(length(slat{3}(:)))./(cusa11-cdsa11);
%Gamma=(Delta_usa11-Delta_dsa11)./(cusa11-cdsa11);
            h=0.05;
p1=computeDeltaBermudan(S0-h, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);

            
p2=computeDeltaBermudan(S0+h, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);

Gamma=(p2-p1)./(2*h);


end