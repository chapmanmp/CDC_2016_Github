function [FittedData_AllWells] = GetFittedData_AllWells_ForBootstrap(CompositeData, NumTimePoints)

[~, NumSamples] = size(CompositeData); NumWells = NumSamples/NumTimePoints;

[DynamicsMatrix_Linear_AllWells] = GetLinearModel(CompositeData, NumTimePoints);

FittedData_InitialCondition = CompositeData(:,1:NumWells); %Set initial condition of fitted data to that of composite data.

FittedData_AllWells = [FittedData_InitialCondition DynamicsMatrix_Linear_AllWells*CompositeData(:,1:NumSamples-NumWells)];
%NumSamples = 24
%NumWells = 4
%Cols 1 to 20 = times 0 to 48 hours
%Col 21, 22, 23, 24 = time 60.
