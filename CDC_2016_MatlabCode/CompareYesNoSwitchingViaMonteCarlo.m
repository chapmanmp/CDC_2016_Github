function [MaxDataGeneralizationError_NO_NS, MaxDataGeneralizationError_YES_NS] = CompareYesNoSwitchingViaMonteCarlo(CompositeData, DynMatrix_AllData, NumTimePoints, LengthTimeInterval, StateNames)

%'reasonable' data is likely to be like no-net-switching data. how well does the best net switching matrix do on this 'reasonable' data?

%no net switching = NO_NS
%yes net switching = YES_NS

NumTrials = 10; %Used to find maximum generalization error.

NumTimePoints_Bio = NumTimePoints; 
NumTimePoints_Syn = NumTimePoints; 
NumWells_Syn = 100; 
NumWellsSyn_Train = round(2/3*NumWells_Syn); 
NumWellsSyn_Test = NumWells_Syn - NumWellsSyn_Train;

CompositeData_Bio = CompositeData;

NumTestWellsToPlot = NumWellsSyn_Test;

%NO NET SWITCHING
DynamicsMatrix_SynTruth_NO_NS = DynMatrix_AllData;
FigNum_NO_NS = 1;

%YES NET SWITCHING
BestDynamics_YES_NS = GetBestLinearModel_NetSwitching(CompositeData_Bio,NumTimePoints_Bio);
DynamicsMatrix_SynTruth_YES_NS = BestDynamics_YES_NS;
FigNum_YES_NS = 2;

Errors_NO_NS = ones(NumTrials,1); Errors_YES_NS = ones(NumTrials,1);

for trial = 1:NumTrials
    
    YesPlot = (trial == 1); %Only plot on first trial.
    
    [FittedData_Syn_Test_NO_NS, CompositeData_Syn_Test_NO_NS] = GetFittedAndSyntheticTestData(DynamicsMatrix_SynTruth_NO_NS, CompositeData_Bio, NumTimePoints_Bio, NumTimePoints_Syn, NumWellsSyn_Train, NumWellsSyn_Test);
    %FittedData_Syn_Test_NO_NS = FittedData_Syn_Test_UsingSynTrainModel.
    
    Errors_NO_NS(trial) = norm(FittedData_Syn_Test_NO_NS-CompositeData_Syn_Test_NO_NS,'fro'); %Generalization error between fitted and synthetic test data, no net switching.
    
    FittedData_Syn_Test_YES_NS = FitGivenDataToGivenLinearModelEstimate(DynamicsMatrix_SynTruth_YES_NS, CompositeData_Syn_Test_NO_NS, NumWellsSyn_Test);
    %Fit synthetic test data generated from no-net-switching matrix to yes-net-switching matrix. How bad is this fit? If fit is not so bad, then it's fine to assume net switching.

    Errors_YES_NS(trial) = norm(FittedData_Syn_Test_YES_NS-CompositeData_Syn_Test_NO_NS,'fro');
    
    if (YesPlot)
        PlotFittedAndOriginalData(FittedData_Syn_Test_NO_NS, CompositeData_Syn_Test_NO_NS, NumWellsSyn_Test, LengthTimeInterval, StateNames, NumTestWellsToPlot, FigNum_NO_NS);
        PlotFittedAndOriginalData(FittedData_Syn_Test_YES_NS, CompositeData_Syn_Test_NO_NS, NumWellsSyn_Test, LengthTimeInterval, StateNames, NumTestWellsToPlot, FigNum_YES_NS);
    end
   
end

MaxDataGeneralizationError_NO_NS = max(Errors_NO_NS);

MaxDataGeneralizationError_YES_NS = max(Errors_YES_NS);


