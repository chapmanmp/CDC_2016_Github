%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Extract switching gains from dynamics matrix for analysis. Used for linear model only.

%INPUTS: DynamicsMatrix - format specified in 'III. VALIDATE MODEL';

%OUTPUTS: Row vector of switching gains in order: p12, p13, ..., p1P, ..., pP1, pP2, ..., pP(P-1). (P = number of phenotypes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function SwitchingGains = GetSwitchingGains(DynamicsMatrix)

[~,NumStates] = size(DynamicsMatrix);

StackedParametersHorz = StackParametersHorizontally_LinearModel(DynamicsMatrix); %Stacks parameters in a row vector.

SwitchingGains = [];

for i = 1:length(StackedParametersHorz) %Iterate thru gains.
    
    if (mod(i,NumStates+1) ~= 1 && mod(i,NumStates) ~= 0) % if not cell division gain AND not death gain, then parameter must be a switching gain!
        
        SwitchingGains = [SwitchingGains StackedParametersHorz(i)]; 
        
    end
    
end
