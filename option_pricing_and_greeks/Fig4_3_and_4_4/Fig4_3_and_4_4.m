clear;
clc;
tic
alpha = 1.9999;
r = 0.1; 
T = 0.5;
Strike = 95;
NumOfTimeSteps=13;
 Sigma=0.10;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
M_Bermudan=2;
 
 Underlying=100;
 
[ x,AsianADelta, AsianAGamma ] = Interp_AuxLatticeGreeksAsianA(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ x,AsianGDelta, AsianGGamma ] = Interp_AuxLatticeGreeksAsianG(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ x,EuropeanDelta, EuropeanGamma ] = Interp_AuxLatticeGreeksEuropean(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ x,AmericanDelta, AmericanGamma ] = Interp_AuxLatticeGreeksAmerican(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ x,BermudanDelta, BermudanGamma ] = Interp_AuxLatticeGreeksBermudan(Underlying, Strike, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);
            
            
            
            figure(1)
            hold on
            plot(x,AmericanDelta,'r')
            plot(x,BermudanDelta,'b')
            plot(x,EuropeanDelta,'m')
            plot(x,AsianADelta,'g')
            plot(x,AsianGDelta,'k')
                
            legend('American','Bermudan','European','Asian Arithmetic','Asian Geometric')
            xlim([min(x) max(x)])    
            title('Deltas')
            
            hold off
            
            figure(2)
            hold on
            
            plot(x,AmericanGamma,'k')
            plot(x,BermudanGamma,'r')
            plot(x,EuropeanGamma,'b')
            plot(x,AsianAGamma,'m')
            plot(x,AsianGGamma,'g')
                
             legend('American','Bermudan','European','Asian Arithmetic','Asian Geometric')
             title('Gammas')
             xlim([min(x) max(x)])  
             hold off
             
    toc         
            