%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Extract parameters from linear model. Output parameters in a form for easy analysis.

%INPUTS: CompositeData - data set containing all time points, all states,
%any selection of wells; NumTimePoints - number of time points.

%OUTPUTS: CellDivisionGains - row vector of cell division gains in order: p1, p2, ..., pP (P = number of phenotypes); 
%DeathGains - row vector of death gains in order: p1D, p2D, ..., pPD;
%SwitchingGains - row vector of switching gains in order: p12, p13, ..., p1P, ..., pP1, pP2, ..., pP(P-1);
%DynamicsMatrixToAnalyze - dynamics matrix, form specified in 'III. VALIDATE MODEL'. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CellDivisionGains, DeathGains, SwitchingGains, DynamicsMatrixToAnalyze] = GetModelResults(CompositeData,NumTimePoints)

DynamicsMatrixToAnalyze = GetLinearModel(CompositeData,NumTimePoints);

[~,NumStates] = size(DynamicsMatrixToAnalyze);

CellDivisionGains = ones(1,NumStates)*DynamicsMatrixToAnalyze; CellDivisionGains(end) = []; %Last col of dynamics matrix is specified.

DeathGains = DynamicsMatrixToAnalyze(end,:); DeathGains(end) = [];

SwitchingGains = GetSwitchingGains(DynamicsMatrixToAnalyze);



