function [ newXSamplePoints,smoothedYDelta, smoothedYGamma ] = Interp_AuxLatticeGreeksAsianG(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)

            
            
[x1,delta1, gamma1 ] = AuxLatticeGreeksAsianG(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);

[x2,delta2,gamma2]= AuxLatticeGreeksAsianG(min(x1), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            k=0;
            for i=1:(2*NumOfTimeSteps+1)-4
            if (x2(i)<min(x1))
                k=k+1;
                x_2(k)=x2(i);
                delta_2(k)=delta2(i);
                gamma_2(k)=gamma2(i);
                
            end
            end
[x3,delta3,gamma3]= AuxLatticeGreeksAsianG(max(x1), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);  
            k=0;
            for i=1:(2*NumOfTimeSteps+1)-4
            if (x3(i)>max(x1))
                k=k+1;
                x_3(k)=x3(i);
                delta_3(k)=delta3(i);
                gamma_3(k)=gamma3(i);
            end
            end
                


x=[x_3';x1';x_2'];
delta=[delta_3';delta1';delta_2'];
gamma=[gamma_3';gamma1';gamma_2'];


samplingRateIncrease = 20;
newXSamplePoints = linspace(min(x), max(x), length(x) * samplingRateIncrease);

smoothedYDelta = spline(x, delta, newXSamplePoints);
 
smoothedYGamma = spline(x, gamma, newXSamplePoints);
end

