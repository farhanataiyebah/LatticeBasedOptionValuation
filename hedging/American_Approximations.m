function [Delta_approx, Del_Gam_approx,FullValue_approx ] = American_Approximations(S0,St,K1,K3,mp,mc1,mc2,T_51,tau,r_51,est_sig,Call_1,Call_2,NumOfTimeSteps,alpha,lambda,M)

put = Call_1 + K1*exp(-r_51*T_51)- S0*exp(-r_51*T_51);
% Black-Scholes delta and gamma
%Del_Call_1 = blsdelta(S0, K1,r, T, est_sig, q);
%Del_Put    = Del_Call_1 - 1 ;
%Del_Call_2 = blsdelta(S0, K3,r, T, est_sig, q);
%---------------------------------
%Gam_Call_1 = blsgamma(S0, K1, r, T, est_sig, q);%
%Gam_Put    = Gam_Call_1 ;
%Gam_Call_2 = blsgamma(S0, K3, r, T, est_sig, q);

%model dependent portfolio hedge factors for full portfolio
%computeDeltaAsian(S0, Strike, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, StrCallPut);


Del_prfl    = mp*(computeDeltaAmerican(S0, K1, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, 'Put')) +  mc1*(computeDeltaAmerican(S0, K1, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, 'Call'))...,  
                    + mc2* (computeDeltaAmerican(S0, K3, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, 'Call'));
                
Gam_prfl    = mp*(computeGammaAmerican(S0, K1, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, 'Put')) +  mc1*(computeGammaAmerican(S0, K1, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, 'Call'))...,  
                    + mc2* (computeGammaAmerican(S0, K3, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, 'Call'));
                 
%[BS_Call_1, BS_Put] = blsprice(St, K1, r_51, T_51-tau, est_sig, q_51);
%BS_Call_2 = blsprice(St, K3, r_51, T_51-tau ,est_sig, q_51);

American_Call_1=priceOptionTrinCEVAmericanTry1(St, K1, r_51, T_51-tau, ...
                NumOfTimeSteps,  est_sig,alpha,lambda,M, 'Call');
American_Put=priceOptionTrinCEVAmericanTry1(St, K1, r_51, T_51-tau, ...
                NumOfTimeSteps,  est_sig,alpha,lambda,M, 'Put');
American_Call_2 =priceOptionTrinCEVAmericanTry1(St, K3, r_51, T_51-tau, ...
                NumOfTimeSteps,  est_sig,alpha,lambda,M, 'Call');
%%%% portfolio value today
P0 = mp*put + mc1*Call_1 + mc2*Call_2 ;

%Delta approximation
Delta_approx = P0 + Del_prfl * (St - S0) ;

% Delta_Gamma approximation
Del_Gam_approx = P0 + Del_prfl *(St-S0) + 0.5*Gam_prfl*(St - S0)^2;

%%% full valuation
FullValue_approx = mp*American_Put + mc1*American_Call_1  +  mc2*American_Call_2 ;


