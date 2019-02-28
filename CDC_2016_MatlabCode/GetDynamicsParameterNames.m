%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Create cell of dynamics parameters names. Dynamics parameters = entries in dynamics matrix, does NOT include noise coefficients.

%INPUT: Cell of state labels. Last entry is always D for dead cells. Previous entries are phenotypes.

%Example: State 1 = G, State 2 = R, State 3 = N, State 4 = D.

%OUTPUT: 
%DynamicsParameters{1} = 'p_G';
%DynamicsParameters{2} = 'p_{GR}';
%DynamicsParameters{3} = 'p_{GN}'; 
%DynamicsParameters{4} = 'p_{GD}';
%DynamicsParameters{5} = 'p_{RG}'; 
%DynamicsParameters{6} = 'p_{R}'; 
%DynamicsParameters{7} = 'p_{RN}'; 
%DynamicsParameters{8} = 'p_{RD}';
%DynamicsParameters{9} = 'p_{NG}';
%DynamicsParameters{10} = 'p_{NR}'; 
%DynamicsParameters{11} = 'p_{N}'; 
%DynamicsParameters{12} = 'p_{ND}';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DynamicsParameters = GetDynamicsParameterNames(StateLabels)

NumStates = length(StateLabels);
DynamicsParameters = cell(NumStates*(NumStates-1),1);

for j = 1:NumStates-1 %Iterate along columns of parameter matrix (= dynamics matrix with alpha terms replaced by cell division parameters).
    FromState = StateLabels{j};
    for i = 1:NumStates %Iterate along rows of parameter matrix.
        if (i==j), ToState = '';
        else ToState = StateLabels{i}; end
        DynamicsParameters{(j-1)*NumStates + i} = ['p_','{',FromState,ToState,'}'];
    end
end