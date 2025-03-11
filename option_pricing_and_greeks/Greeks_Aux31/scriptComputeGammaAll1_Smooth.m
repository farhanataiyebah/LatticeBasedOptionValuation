
 clear;
clc;
tic
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=7;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 M_Bermudan=2;

 Underlying=50:150;

for i=1:length( Underlying)
[ Gamma_Asian(i) ] = computeGammaAsian1(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_European(i) ] = computeGammaEuropean1(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_American(i) ] = computeGammaAmerican(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
[ Gamma_Bermudan(i) ] = computeGammaBermudan1(Underlying(i), Strike, r, T, ...
                NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, StrCallPut);            
end

 %%
 
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
Gamma_bls = blsgamma(Underlying, Strike, r, T,Sigma);

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