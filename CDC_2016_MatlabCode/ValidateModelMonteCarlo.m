%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Use Monte Carlo simulation to validate model.

%OUTPUT: Error between true & identified dynamics matrix.

%Applicable to linear model only.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [RoughVarianceEstimate, Error_DynamicsMatrix] = ValidateModelMonteCarlo(DynamicsMatrix_PlausibleTruth, CompositeData_Bio, NumTimePoints_Bio, NumTimePoints_Syn, NumWellsSyn_Train, NumWellsSyn_Test, StateLabels, LengthTimeInterval, FigNum)
%Bio = biological experiment, Syn = synthetic experiment. 

%1. Get synthetic data set.
NumWells_Syn = NumWellsSyn_Train + NumWellsSyn_Test;
[CompositeData_Synthetic,  RoughVarianceEstimate] = GetSyntheticData(DynamicsMatrix_PlausibleTruth, CompositeData_Bio, NumTimePoints_Bio, NumTimePoints_Syn, NumWells_Syn);

%2. Separate synthetic data set into train and test sets. 
[CompositeData_Syn_Train, CompositeData_Syn_Test] = GetTrainTestData(CompositeData_Synthetic, NumWellsSyn_Train, NumWellsSyn_Test, NumTimePoints_Syn);

%3. Identify model using synthetic training data.
[DynamicsMatrix_Linear_FromSynTrain] = GetLinearModel(CompositeData_Syn_Train,NumTimePoints_Syn);

%4. Compute error: synthetic truth & model identified from training data.
Error_DynamicsMatrix = norm(DynamicsMatrix_PlausibleTruth-DynamicsMatrix_Linear_FromSynTrain,'fro');

%5. Compare fitted/predicted trajectories vs. synthetic test data.
[PredictedTestData_Syn_UsingModelFromSynTrainData] = GetPredictedTestData_UsingModelFromTrainData(DynamicsMatrix_Linear_FromSynTrain, CompositeData_Syn_Test, NumWellsSyn_Test);
NumTestWellsToPlot = 33;
PlotPredictedVsOriginalTraj(PredictedTestData_Syn_UsingModelFromSynTrainData, CompositeData_Syn_Test, NumWellsSyn_Test, LengthTimeInterval, StateLabels, NumTestWellsToPlot, FigNum);





