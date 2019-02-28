%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Separate composite data set into one set for training and another for testing.

%ASSUMPTIONS: CompositeData argument is in the format as specified in 'II. CREATE COMPOSITE DATA SET'.

%INPUTS: CompositeData - entire data set (i.e., contains all wells, phenotype counts, dead cells counts);
%NumTrainWells - number of training wells, NumTestWells - number of test wells, T - number of time points.

%OUTPUTS: Data set used for training and data set used for testing, with format specified in 'III. VALIDATE MODEL'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CompositeData_Train, CompositeData_Test] = GetTrainTestData(CompositeData,NumTrainWells,NumTestWells,NumTimePoints)

CompositeData_Train = [];
CompositeData_Test = []; 
FirstColTrain = 1; 
for time = 1:NumTimePoints
    LastColTrain = FirstColTrain + NumTrainWells - 1;
    
    CompositeData_Train = [CompositeData_Train CompositeData(:,FirstColTrain:LastColTrain)];
    
    FirstColTest = LastColTrain+1;
    LastColTest = FirstColTest + NumTestWells - 1;
    
    CompositeData_Test = [CompositeData_Test CompositeData(:,FirstColTest:LastColTest)];
    
    FirstColTrain = LastColTest + 1;
end
