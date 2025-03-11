
	
	

function [value,delta,gamma,theta,vega,rho] = BinomialTreeGreeks(putCall,...
exerciseType,S0,K,sigma,r,div,T,n)
%
% This function calculates the American or European option value by a
% binomal tree model.
%
% [value,delta,gamma,theta,vega,rho] = ...
% BinomialTreeGreeks(putCall,exerciseType,S0,K,sigma,r,div,T,n)
%
% Input: putCall: indicates the option type
% putCall = ’Call’ for a call option
% putCall = ’Put’ for a put
% option
% exerciseType: European (’E’) or American (’A’)
% exercise type
% S: Stock price
% K: Strike price
% sigma: Volatility
% r: riskfree rate
% div: Dividend yield
% T: Time to maturity
% n: Number of steps in the tree
%
% OUTPUT: value: option value
% delta: dV/dS
% gamma: dV^2/d^2S
% theta: dV/dT
% vega: dV/dsigma
% rho: dV/dr
%
% EXAMPLE: [value,delta,gamma,theta,vega,rho] = ...
% BinomialTreeGreeks(’Put’,’A’,50,50,0.4,0.05,0.02,2,500)
% Parameters for binomial tree
dt = T/n;
u = exp(sigma*sqrt(dt));
d = 1/u;
p = (exp((r-div)*dt)-d)/(u-d);
q = 1-p;
disc = exp(-r*dt);
% Initialize matrices
stockM = zeros(n+1,n+1);
optionM = zeros(n+1,n+1);
% Create stock tree
stockM (1,1) = S0;
for j = 2:n+1
for i = 1:j-1
stockM(i,j) = stockM(i,j-1)*u;
end
stockM(i+1,j) = stockM(i,j-1)*d;
end
% Set z parameter to calculate the option payoff depending on the
% selected option type (Call, Put)
switch putCall
case 'Call'
z = 1;
case 'Put'
z = -1;
otherwise
error('Check option type!');
end
% Insert terminal values
optionM(:,end) = max(z*(stockM(:,end)-K),0);
% Value call by working backward from time n-1 to time 0
switch exerciseType
% European option
case 'E'
for j=n:-1:1;
for i=j:-1:1;
optionM(i,j) = disc*(p*optionM(i,j+1)+q*optionM(i+1,j+1));
end
end;
% American exercise type
case 'A'
for j=n:-1:1;
for i=j:-1:1;
optionM(i,j) = max(z*(stockM(i,j)-K),disc*(p*optionM(i,j+1)+q*optionM(i+1,j+1)));
end
end
otherwise
error('Check exercise type!');
end
value = optionM(1,1);
% Calculate greeks
if nargout > 1
delta = (optionM(1,2)-optionM(2,2))/(stockM(1,2)-stockM(2,2));
end
if nargout > 2
deltaUp = (optionM(1,3)-optionM(2,3))/(stockM(1,3)-stockM(2,3));
deltaDown = (optionM(2,3)-optionM(3,3))/(stockM(2,3)-stockM(3,3));
gamma = (deltaUp-deltaDown)/((stockM(1,3)-stockM(3,3))/2);
end
if nargout > 3
theta = (optionM(2,3)-optionM(1,1))/(2*dt);
end
% Calculate vega and rho with re-evaluation
if nargout > 4
vegaUp = feval(@BinomialTreeGreeks,putCall,exerciseType,S0,K,...
sigma+0.01,r,div,T,n);
vegaDown = feval(@BinomialTreeGreeks,putCall,exerciseType,S0,K,...
sigma-0.01,r,div,T,n);
vega = (vegaUp - vegaDown)/(2*0.01);
end
if nargout > 5
rhoUp = feval(@BinomialTreeGreeks,putCall,exerciseType,S0,K,sigma,...
r+0.01,div,T,n);
rhoDown = feval(@BinomialTreeGreeks,putCall,exerciseType,S0,K,sigma,...
r-0.01,div,T,n);
rho = (rhoUp - rhoDown)/(2*0.01);
end