function ConfidenceIntervalStatistics=ImplementBootstrap(CompositeData,FittedData,NumDataSets,NumTimePoints, FractionforConfidenceInterval)
%CompositeData = data set derived from experimental observations, all wells
%FittedData = fitted data, all wells

ParameterSet = [];

for k = 1:NumDataSets
    
    BootstrapSet = ComputePerturbedDataSet_WildBootstrap(CompositeData,FittedData,NumTimePoints); %Get bootstrapped observations.
    
    [DynamicsMatrixFromBootstrapSet] = GetLinearModel(BootstrapSet,NumTimePoints); %Regress bootstrapped observations to get bootstrap regression coefficients (new dynamics matrix).
    
    StackedParametersHorz = StackParametersHorizontally_LinearModel(DynamicsMatrixFromBootstrapSet);
    
    ParameterSet = [ParameterSet; StackedParametersHorz];
end

ConfidenceIntervalStatistics = GetConfidenceIntervalStatistics(ParameterSet, FractionforConfidenceInterval); %Compute confidence intervals for regression coefficients.



