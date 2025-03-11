clear;
clc;
tic
alpha = 1.99999;
r = 0.01;

T = 0.5;
Strike = 95;
NumOfTimeSteps=10;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
M_Bermudan=2; 

 Underlying=50:5:150;
 
 for i=1:length( Underlying)
    %i=5 

[ Gamma_Asian(i) ] = TrinGammaAsianp(Underlying(i), Strike, r, T, ...
               NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut) ;
            
[ Gamma_European(i) ] = TrinGammaEuropeanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
[ Gamma_Bermudan(i)] = TrinGammaBermudanp(Underlying(i), Strike, r, T, ...
               NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, StrCallPut)  ;
            
[ Gamma_American(i) ] = TrinGammaAmericanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)  ;          
 end
 
 x = Underlying;  
 xx = 50:.25:150;
 %smoothing Gamma Asian
        
        y_Asian = spline(x,Gamma_Asian,xx);
        
 %smoothing Gamma European
      
        y_European = spline(x,Gamma_European,xx);
        
 %smoothing Gamma Bermudan
        
        y_Bermudan = spline(x,Gamma_Bermudan,xx); 
        
  %smoothing Gamma American
      
        y_American = spline(x,Gamma_American,xx);       
        
        
 


 %%
 Gamma_bls = blsgamma(xx, Strike, r, T,Sigma);
 figure
 plot(xx,y_Asian,'k');
 hold on
 
 
 plot(xx,y_European,'b');
 hold on
 
 plot(xx, Gamma_bls,'r');
 hold on
 
 plot(xx,y_Bermudan,'g');
 hold on
 
 plot(xx,y_American,'m');

 
 legend('gammaAsian','gammaEuropean','gammabls','gammaBermudan','gammaAmerican')
 
 saveas(gcf,'Gammap_All_smooth.png')
 axis tight
 hold off
 toc
 %%
%lengthX = length(Underlying);
%samplingRateIncrease = 10;
%newXSamplePoints = linspace(min(Underlying), max(Underlying), lengthX * samplingRateIncrease);
%smoothedY = spline(Underlying,Gamma_European , newXSamplePoints);
% Now flip back
%Gamma_European_Smooth = newXSamplePoints;
%Underlying_Smooth = smoothedY;
%plot(Underlying,Gamma_European, 'r');
% Plot smoothedY and show how the line is
% smooth, and has no sharp bends.
%hold on; % Don't destroy the first curve we plotted.
%plot(Underlying_Smooth, Gamma_European_Smooth, 'g');
%legend('blsGamma','GammaEuropean','SmoothGammaEuropean')
%grid on;
% Create the original knot points.
