%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Stack parameters horizonally for model sensitivity evaluation. Applies to linear model.
%INPUTS: DynamicsMatrix - dynamics matrix associated with linear model.
%OUTPUTS: Parameters stacked horizontally in format specified in 'IV. EVALUATE MODEL SENSITIVITY.'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function StackedParametersHorz = StackParametersHorizontally_LinearModel(DynamicsMatrix)

StackedParametersHorz = [];

[~, NumStates] = size(DynamicsMatrix);

for j = 1:NumStates-1 %Last column of Dynamics matrix is previously specified.
    Columnj = DynamicsMatrix(:,j); %Extract jth column from dynamics matrix.
    Columnj(j) = sum(Columnj); %Replace diagonal term with cell division gain.
    StackedParametersHorz = [StackedParametersHorz Columnj'];
end




