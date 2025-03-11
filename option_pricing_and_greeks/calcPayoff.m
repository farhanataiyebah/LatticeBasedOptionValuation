function PayoffValue = calcPayoff(Underlying, Strike, StrCallPut)
% The function calculates a standard European option payoff 
% Input: 
% Underlying
% Strike
% StrCallPut: 'Call' or 'Put' (default is 'Call')
%
% Output:
% PayoffValue = max(Underlying - Strike, 0)
%
% Note: the function can be easily modified for other exotic options
% 
% Bowei Chen | PhD
% University College London
% bowei.chen@cs.ucl.ac.uk
% 03/2015

if strcmp(StrCallPut, 'put') || strcmp(StrCallPut, 'Put')
    PayoffValue = max(Strike - Underlying, 0);
else
    PayoffValue = max(Underlying - Strike, 0);
end

end % end of func

