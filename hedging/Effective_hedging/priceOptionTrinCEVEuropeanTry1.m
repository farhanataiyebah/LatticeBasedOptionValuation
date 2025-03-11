function [OptionPrice, TrinLatticeUnderlying, TrinLatticeOption] = ...
                priceOptionTrinCEVEuropeanTry1(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut)
% The function calculates a standard European option price by using
% the Tian's trinomial model
% Ref: Tian, Y., 1993. A modified lattice approach to option pricing. 
% The Journal of Futures Markets.
%
% Input: 
% Underlying: initial value of underlying price
% Strike: strike/exercise price
% Rate: continuous-time risk-less rate
% T: in terms of year format
% NumOfTimeSteps: how many steps specified for T, where dt := T/TimeSteps
% Sigma: volatility
% StrCallPut: 'Call' or 'Put' (default is 'Call')
%
% Output:
% OptionPrice
% BinLatticeUnderlying
% BinLatticeOption
% 
% Bowei Chen | PhD
% University College London
% bowei.chen@cs.ucl.ac.uk
% 03/2015   
            
                        
%% Initialization
dt = T / NumOfTimeSteps;
DISFACTOR = exp(r * dt);
%------------------------------
sig=Sigma*(Underlying^(1-alpha/2));
nu=sig;
%------------------------------
%dt=T/N;
delY=lambda*nu*sqrt(dt);
%------------------------------
y0=(nu*(Underlying^(1-alpha/2)))/(sig*(1-alpha/2));
Y=(y0-M*delY):delY:(y0+M*delY);

YnonpositiveI=find(Y<=0);
S1=0*Y(YnonpositiveI);
YpositiveI=find(Y>0);
S2=((Y(YpositiveI)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2));

Sgrid=[S1 S2];%union(S1,S2); 
SpositiveI=min(find(Sgrid>0));

%----------
%Sgrid=Sgrid(SpositiveI:end)
%Y=Y(SpositiveI:end)
%----------

KI=round((Y*((1+r*dt)^(1-alpha/2))-y0)./(lambda*nu*sqrt(dt)));%floor((Y*((1+r*dt)^(1-alpha/2))-y0)./(lambda*nu*sqrt(dt)));%
% Loop over each node of underlying price tree
TrinLatticeUnderlying = buildLatticeAsian(NumOfTimeSteps+1, 'trin');
ProbLattice=buildLatticeAsian(NumOfTimeSteps+1, 'trin');
TrinLatticeStock = buildLatticeAsian(NumOfTimeSteps+1, 'trin');
%--------------------------
TrinLatticeUnderlying{1}(1) = Underlying;
TrinLatticeStock{1}(1) = Underlying;
%--------------------------
for Idx = 2:NumOfTimeSteps+1
    %Idx
    for Onelag=1:length(TrinLatticeUnderlying{Idx-1})
    %---------------------------
    
    
    if TrinLatticeUnderlying{Idx-1}(Onelag)~=0 %&& isnan(TrinLatticeUnderlying{Idx}(i))~=1 %TrinLatticeUnderlying{Idx-1}(i-2*count)~=0
    %J=(find(abs(Sgrid-TrinLatticeUnderlying{Idx-1}(i-2*count))==min(abs(Sgrid-TrinLatticeUnderlying{Idx-1}(i-2*count)))))%J=(find(abs(S-TrinLatticeUnderlying{Idx}(i))<=0.000002));%J=find(abs(S-allS(end))<=0.000002);
    %Sgrid
    %TrinLatticeUnderlying{Idx-1}(Onelag)
    %min(abs(Sgrid-TrinLatticeUnderlying{Idx-1}(Onelag)))
    J=(find(abs(Sgrid-TrinLatticeUnderlying{Idx-1}(Onelag))==min(abs(Sgrid-TrinLatticeUnderlying{Idx-1}(Onelag)))));%J=(find(abs(S-TrinLatticeUnderlying{Idx}(i))<=0.000002));%J=find(abs(S-allS(end))<=0.000002);
    Mj=Sgrid(J)+r*Sgrid(J)*dt;
    Vj=(sig.^2)*((Sgrid(J)).^alpha)*dt;
    k=KI(J);
    %-----------------------------
    %YI=find(abs(Y-(y0+k*delY))==min(abs(Y-(y0+k*delY))));%YI=find(abs(Y-(y0+k*delY))<0.000002);
    %Su= S(find(S==((Y(YI)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2)))+1)%S(k+1);%           S(min(find(S>Mj)))          %
    %Sm= S(find(S==((Y(YI)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2))))%S(k);    %           Mj         %
    %Sd= S(find(S==((Y(YI)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2)))-1)%S(k-1);%           S(max(find(S<Mj)))            % 
    %------------------------------
    %------------------------------
    k=round((Y(J)*((1+r*dt)^(1-alpha/2))-y0)./(lambda*nu*sqrt(dt)));
    Jk=1+k+(M);
    Su=Sgrid(Jk+1);
    Sm=Sgrid(Jk);
    Sd=Sgrid(Jk-1);
    %-------------
    %if J~=Jk
    %    highDrift=highDrift+1;
    %end
    %highDrift;
    %---------------------------------
    %Su=Sgrid(find(abs(Sgrid-Mj)==min(abs(Sgrid-Mj)))+1);%S(k+1);%S(k+1);
    %Sm=Sgrid(find(abs(Sgrid-Mj)==min(abs(Sgrid-Mj))));%S(k);%S(k);
    %find(abs(Sgrid-Mj)==min(abs(Sgrid-Mj)))-1
    %Sd=Sgrid(find(abs(Sgrid-Mj)==min(abs(Sgrid-Mj)))-1);%S(k-1);%S(k-1);
    %------------------------------
    %YIu=find(abs(Y-(y0+(k)*delY))<0.000002);
    %Su=Sgrid(find(Sgrid==((Y(YIu)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2)))+1);%S(k+1);
    %YIm=find(abs(Y-(y0+k*delY))<0.000002);
    %Sm=Sgrid(find(Sgrid==((Y(YIm)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2))));%S(k);
    %YId=find(abs(Y-(y0+(k)*delY))<0.000002);
    %Sd=Sgrid(find(Sgrid==((Y(YId)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2)))-1);%S(k-1);
    %------------------------------
    Snode=[Su Sm Sd];
    Pnode=[((Sm-Mj)*(Sd-Mj)+Vj)/((Sm-Su)*(Sd-Su))  ((Su-Mj)*(Sd-Mj)+Vj)/((Su-Sm)*(Sd-Sm))  ((Su-Mj)*(Sm-Mj)+Vj)/((Su-Sd)*(Sm-Sd))];
    else
        %Su=Sgrid(find(Sgrid==((Y(SpositiveI)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2))));
        %Sd=0;
        Su=0;
        Sm=0;
        Sd=0;
        Snode=[Su Sm Sd];%  [Su Sm Sd];%[Sgrid(find(Sgrid==((Y(SpositiveI)*sig*(1-alpha/2))/nu).^(1/(1-alpha/2)))) 0 0];% 
        Pnode=[0 0 0];%[1 0 0];%[((Sm-Mj)*(Sd-Mj)+Vj)/((Sm-Su)*(Sd-Su)) 0 0]%
    end       
    %---------------------------
    TrinLatticeUnderlying{Idx}(Onelag+2*(Onelag-1)+0) = Su;%TrinLatticeUnderlying{Idx-1}(Onelag)*u;
    TrinLatticeUnderlying{Idx}(Onelag+2*(Onelag-1)+1) = Sm;%TrinLatticeUnderlying{Idx-1}(Onelag)*m;
    TrinLatticeUnderlying{Idx}(Onelag+2*(Onelag-1)+2) = Sd;%TrinLatticeUnderlying{Idx-1}(Onelag)*d; 
    ProbLattice{Idx}(Onelag+2*(Onelag-1)+0) = Pnode(1);%TrinLatticeUnderlying{Idx-1}(Onelag)*u;
    ProbLattice{Idx}(Onelag+2*(Onelag-1)+1) = Pnode(2);%TrinLatticeUnderlying{Idx-1}(Onelag)*m;
    ProbLattice{Idx}(Onelag+2*(Onelag-1)+2) = Pnode(3);%TrinLatticeUnderlying{Idx-1}(Onelag)*d;     
    %---------------------------
    TrinLatticeStock{Idx}(Onelag+2*(Onelag-1)+0) =TrinLatticeUnderlying{Idx}(Onelag+2*(Onelag-1)+0);
    TrinLatticeStock{Idx}(Onelag+2*(Onelag-1)+1) =TrinLatticeUnderlying{Idx}(Onelag+2*(Onelag-1)+1);
    TrinLatticeStock{Idx}(Onelag+2*(Onelag-1)+2) =TrinLatticeUnderlying{Idx}(Onelag+2*(Onelag-1)+2);
    %---------------------------
    %---------------------------
    %x = length(TrinLatticeUnderlying{Idx});
    %if  x > 3
    %    for k = 4:x
    %        k
    %        TrinLatticeUnderlying{Idx}(k) = TrinLatticeUnderlying{Idx-1}(k-2)*d
    %    end
    %end
    %clear x    
    end
end
%------for Asian try------
%TrinLatticeUnderlying{:} %for Asian
%mean(TrinLatticeUnderlying{:}) %for Asian
%-------------------------

%% Calculate the value at expiry
TrinLatticeOption = buildLatticeAsian(NumOfTimeSteps+1, 'trin');
for k = 1:length(TrinLatticeOption{end})
    TrinLatticeOption{end}(k) = calcPayoff(TrinLatticeStock{end}(k), ...
        Strike, StrCallPut);
end

%% Loop backwards to get values at the earlier times
for Idx = NumOfTimeSteps:-1:1
    for k = 1:length(TrinLatticeOption{Idx})
        %------------------
        %TrinLatticeOption{Idx}(k) = ...
        %    r^-1 * (q1 * TrinLatticeOption{Idx+1}(k) ...
        %        + q2 * TrinLatticeOption{Idx+1}(k+1) ... 
        %        + q3 * TrinLatticeOption{Idx+1}(k+2));
        %------------------    
        TrinLatticeOption{Idx}(k) = ...
           DISFACTOR^-1 * (ProbLattice{Idx+1}(k+2*(k-1)+0) * TrinLatticeOption{Idx+1}(k+2*(k-1)+0) ...
                + ProbLattice{Idx+1}(k+2*(k-1)+1) * TrinLatticeOption{Idx+1}(k+2*(k-1)+1) ... 
                + ProbLattice{Idx+1}(k+2*(k-1)+2) * TrinLatticeOption{Idx+1}(k+2*(k-1)+2));
        %------------------    
    end
end
OptionPrice = TrinLatticeOption{1}(1); 
end % end of func
