function [FittedData_Syn_Test_UsingSynTrainModel, CompositeData_Syn_Test] = GetFittedAndSyntheticTestData(DynamicsMatrix_SynTruth, CompositeData_Bio, NumTimePoints_Bio, NumTimePoints_Syn, NumWellsSyn_Train, NumWellsSyn_Test)

%Bio = biological experiment, Syn = synthetic experiment. 

%1. Get synthetic data set.
NumWells_Syn = NumWellsSyn_Train + NumWellsSyn_Test;
CompositeData_Synthetic = GetSyntheticData(DynamicsMatrix_SynTruth, CompositeData_Bio, NumTimePoints_Bio, NumTimePoints_Syn, NumWells_Syn);

%2. Separate synthetic data set into train and test sets. 
[CompositeData_Syn_Train, CompositeData_Syn_Test] = GetTrainTestData(CompositeData_Synthetic, NumWellsSyn_Train, NumWellsSyn_Test, NumTimePoints_Syn);

%3. Identify model using synthetic training data.
[DynamicsMatrix_Linear_FromSynTrain] = GetLinearModel(CompositeData_Syn_Train,NumTimePoints_Syn);

%4. Fit synthetic test data to model derived from synthetic train data.
[FittedData_Syn_Test_UsingSynTrainModel] = FitGivenDataToGivenLinearModelEstimate(DynamicsMatrix_Linear_FromSynTrain, CompositeData_Syn_Test, NumWellsSyn_Test);





