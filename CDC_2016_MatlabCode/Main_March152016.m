%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Main script for phenotype dynamical model, linear, CDC 2016
%DATE: March 15, 2016
%AUTHOR: Margaret P. Chapman
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all; clc;

path = 'C:\Users\chapmanm\Documents\MATLAB\Biological Networks\Phenotypic State Modeling\CDC_3Phenotype_Linear_March15\PhenotypeDeadExpts_Oct5Data.xlsx';
NumTrainWells = 2; NumTestWells = 2;
Phenotype_Col1 = 'D'; Phenotype_ColLast = 'F'; DeathExpt_TotalCol = 'J'; DeathExpt_DeadCol = 'K';
NumTimePoints = 6; NumConditions = 4; LengthTimeInterval = 12; %Data collected every 12 hours.
NumStates = 4; StateNames = cell(NumStates,1); StateNames{1} = 'Green'; StateNames{2} = 'Red'; StateNames{3} = 'Not'; StateNames{4} = 'Dead'; 
StateLabels = cell(NumStates,1); StateLabels{1} = 'G'; StateLabels{2} = 'R'; StateLabels{3} = 'N'; StateLabels{4} = 'D'; 

%Get phenotype counts and dead cell percentages.
[Control_PhenotypeExpt, Control_DeadExpt, GSK_PhenotypeExpt, GSK_DeadExpt, BEZ_PhenotypeExpt, BEZ_DeadExpt, COMBO_PhenotypeExpt, COMBO_DeadExpt] = GetRawData(path, NumTimePoints, NumTrainWells+NumTestWells, NumConditions, Phenotype_Col1, Phenotype_ColLast, DeathExpt_TotalCol, DeathExpt_DeadCol);

%Create composite data set for mathematical model.
Control_CompositeData = GetCompositeData(Control_PhenotypeExpt,Control_DeadExpt);
GSK_CompositeData = GetCompositeData(GSK_PhenotypeExpt,GSK_DeadExpt);
BEZ_CompositeData = GetCompositeData(BEZ_PhenotypeExpt,BEZ_DeadExpt);
COMBO_CompositeData = GetCompositeData(COMBO_PhenotypeExpt,COMBO_DeadExpt);

%Ensure that death always increases. Verified on 3/8.
Control_CompositeData = MakeDeathIncreasing(Control_CompositeData, NumTimePoints);
GSK_CompositeData = MakeDeathIncreasing(GSK_CompositeData, NumTimePoints);
BEZ_CompositeData = MakeDeathIncreasing(BEZ_CompositeData, NumTimePoints);
COMBO_CompositeData = MakeDeathIncreasing(COMBO_CompositeData, NumTimePoints);
%% Plot composite data for basal.

PlotBasalCompositeData(Control_CompositeData, GSK_CompositeData, BEZ_CompositeData, COMBO_CompositeData, NumTimePoints, LengthTimeInterval);

%% Implement bootstrap algorithm: WILD BOOTSTRAP to detect statistically significant differences.

%Compute fitted data (all wells).
[FittedData_AllWells_Control] = GetFittedData_AllWells_ForBootstrap(Control_CompositeData, NumTimePoints);
[FittedData_AllWells_GSK] = GetFittedData_AllWells_ForBootstrap(GSK_CompositeData, NumTimePoints);
[FittedData_AllWells_BEZ] = GetFittedData_AllWells_ForBootstrap(BEZ_CompositeData, NumTimePoints);
[FittedData_AllWells_COMBO] = GetFittedData_AllWells_ForBootstrap(COMBO_CompositeData, NumTimePoints);

NumDataSetsForBootstrap = 200; FractionforConfidenceInterval = 0.95; %CIS = confidence interval statistics

%Use composite and fitted data from all wells.
CIS_Control = ImplementBootstrap(Control_CompositeData,FittedData_AllWells_Control,NumDataSetsForBootstrap,NumTimePoints,FractionforConfidenceInterval);
CIS_GSK = ImplementBootstrap(GSK_CompositeData,FittedData_AllWells_GSK,NumDataSetsForBootstrap,NumTimePoints,FractionforConfidenceInterval);
CIS_BEZ = ImplementBootstrap(BEZ_CompositeData,FittedData_AllWells_BEZ,NumDataSetsForBootstrap,NumTimePoints,FractionforConfidenceInterval);
CIS_COMBO = ImplementBootstrap(COMBO_CompositeData,FittedData_AllWells_COMBO,NumDataSetsForBootstrap,NumTimePoints,FractionforConfidenceInterval);

VisualizeBootstrapResults(CIS_Control, CIS_GSK, CIS_BEZ, CIS_COMBO)

%% Obtain model results, generated using all wells.

[CellDivisionGains_Control, DeathGains_Control, SwitchingGains_Control, DynMatrix_AllData_Control] = GetModelResults(Control_CompositeData,NumTimePoints);
[CellDivisionGains_GSK, DeathGains_GSK, SwitchingGains_GSK, DynMatrix_AllData_GSK] = GetModelResults(GSK_CompositeData,NumTimePoints);
[CellDivisionGains_BEZ, DeathGains_BEZ, SwitchingGains_BEZ, DynMatrix_AllData_BEZ] = GetModelResults(BEZ_CompositeData,NumTimePoints);
[CellDivisionGains_COMBO, DeathGains_COMBO, SwitchingGains_COMBO, DynMatrix_AllData_COMBO] = GetModelResults(COMBO_CompositeData,NumTimePoints);

CellDivisionGainMatrix = [CellDivisionGains_Control; CellDivisionGains_GSK; CellDivisionGains_BEZ; CellDivisionGains_COMBO]

DeathGainMatrix = [DeathGains_Control; DeathGains_GSK; DeathGains_BEZ; DeathGains_COMBO]

SwitchingGainMatrix = [SwitchingGains_Control; SwitchingGains_GSK; SwitchingGains_BEZ; SwitchingGains_COMBO]

%% Validation using Monte Carlo procedure: Net vs. standard switching

[~, SampleVariance_Control] = GetSampleStatistics(Control_CompositeData, NumTimePoints);
[MaxError_NONetSwitching_Control, MaxError_YESNetSwitching_Control] = CompareYesNoSwitchingViaMonteCarlo(Control_CompositeData, DynMatrix_AllData_Control, NumTimePoints, LengthTimeInterval, StateNames);
%%
[~, SampleVariance_GSK] = GetSampleStatistics(GSK_CompositeData, NumTimePoints);
[MaxError_NONetSwitching_GSK, MaxError_YESNetSwitching_GSK] = CompareYesNoSwitchingViaMonteCarlo(GSK_CompositeData, DynMatrix_AllData_GSK, NumTimePoints, LengthTimeInterval, StateNames);
%%
[~, SampleVariance_BEZ] = GetSampleStatistics(BEZ_CompositeData, NumTimePoints);
[MaxError_NONetSwitching_BEZ, MaxError_YESNetSwitching_BEZ] = CompareYesNoSwitchingViaMonteCarlo(BEZ_CompositeData, DynMatrix_AllData_BEZ, NumTimePoints, LengthTimeInterval, StateNames);
%%
[~, SampleVariance_COMBO] = GetSampleStatistics(COMBO_CompositeData, NumTimePoints);
[MaxError_NONetSwitching_COMBO, MaxError_YESNetSwitching_COMBO] = CompareYesNoSwitchingViaMonteCarlo(COMBO_CompositeData, DynMatrix_AllData_COMBO, NumTimePoints, LengthTimeInterval, StateNames);

MaxErrors = [MaxError_NONetSwitching_Control MaxError_YESNetSwitching_Control; ...
    MaxError_NONetSwitching_GSK MaxError_YESNetSwitching_GSK; ...
    MaxError_NONetSwitching_BEZ MaxError_YESNetSwitching_BEZ; ...
    MaxError_NONetSwitching_COMBO MaxError_YESNetSwitching_COMBO];













%% Control problem

NumWells = NumTrainWells+NumTestWells;
x0 = median([Control_CompositeData(:,1:NumWells) GSK_CompositeData(:,1:NumWells) BEZ_CompositeData(:,1:NumWells) COMBO_CompositeData(:,1:NumWells)],2);

xEnd = DynMatrix_AllData_GSK^10*x0;

[V_GSK, D_GSK] = eig(DynMatrix_AllData_GSK);

PercentGreen = xEnd(1)/sum(xEnd);








