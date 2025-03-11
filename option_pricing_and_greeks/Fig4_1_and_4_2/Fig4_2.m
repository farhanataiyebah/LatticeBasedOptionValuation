
 clear;
clc;
tic
alpha = 1.99999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=13;
 Sigma=0.10;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 M_Bermudan=2;

 Underlying=50:5:150;

for i=1:length( Underlying)
[ Gamma_Asian(i) ] = TrinGammaAsianp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_AsianG(i) ] = TrinGammaAsianGp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_European(i) ] = TrinGammaEuropeanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_American(i) ] = TrinGammaAmericanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_Bermudan(i) ] = TrinGammaBermudanp(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);            
end

 %%
 
 x = Underlying;  
 xx = 50:.1:150;
 %smoothing Gamma Asian
        
        y_Asian = spline(x,Gamma_Asian,xx);
        
 %smoothing Gamma AsianG
        
        y_AsianG = spline(x,Gamma_AsianG,xx);       
        
 %smoothing Gamma European
      
        y_European = spline(x,Gamma_European,xx);
        
 %smoothing Gamma Bermudan
        
        y_Bermudan = spline(x,Gamma_Bermudan,xx); 
        
  %smoothing Gamma American
      
        y_American = spline(x,Gamma_American,xx);       
        
 
 %%
Gamma_bls = blsgamma(Underlying, Strike, r, T,Sigma);

 Gamma_bls = blsgamma(xx, Strike, r, T,Sigma);
 figure
 plot(xx,y_Asian,'k');
 hold on
 
  plot(xx,y_AsianG,'Color',[1 0.5 0]);
 hold on
 

 plot(xx,y_European,'b');
 hold on
 
 plot(xx, Gamma_bls,'r');
 hold on
 
 plot(xx,y_Bermudan,'g');
 hold on
 
 plot(xx,y_American,'m');

 title(' Gamma (Ordinary Lattice) ')
 legend('Asian Arithmetic','Asian Geometric','European','BLS','Bermudan','American')
 xlabel('Underlying')
 ylabel('Gamma')
 saveas(gcf,'Gammap_All_smooth.png')
 axis tight
 hold off
 toc