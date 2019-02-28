%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Extract data matrices for model estimation procedure from composite data set.

%ASSUMPTIONS: None.

%INPUTS: CompositeData - data set containing all states, all time points, and any number of wells. General form specified in 'II. CREATE COMPOSITE DATA SET';
%NumTimePoints - number of time points.

%OUTPUTS: XPRE - data matrix containing all states, wells from CompositeData, times 0 to just prior to final time;
%XPOST - data matrix containing all states, wells from CompositeData, times 1 to final time. (Assume initial time is time 0.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [XPRE, XPOST] = GetDataMatricesForModelEstimation(CompositeData,NumTimePoints)

[NumStates, NumSamples] = size(CompositeData); %NumSamples = NumWells*NumTimePoints.

NumWells = NumSamples/NumTimePoints;

XPOST = CompositeData(:,NumWells+1:end); %Time 12 hrs to 60 hrs.

XPRE = CompositeData(:,1:(NumTimePoints-1)*NumWells); %Time 0 to 48 hrs.