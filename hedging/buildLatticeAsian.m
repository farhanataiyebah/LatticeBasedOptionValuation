function DataStructure = buildLatticeAsian(NumOfTimeSteps, StrBinTrin)
% The function creates a binomial/trinomial lattice 
% Input: 
% NumOfTimeSteps
% StrBinTrin
%
% Output:
% LatticeStructure (start with time 1)
% 
% Bowei Chen | PhD
% University College London
% bowei.chen@cs.ucl.ac.uk
% 03/2015

%%
DataStructure = '';
if strcmp(StrBinTrin, 'trin') || strcmp(StrBinTrin, 'Trin')
    for i = 1:NumOfTimeSteps    
        DataStructure{i} =nan(1,3^(i-1)); % nan(1,2*i-1);    
    end  
else
    for i = 1:NumOfTimeSteps    
        DataStructure{i} =nan(1,2^(i-1)); % nan(1,i);      
    end
end

end % end of func

