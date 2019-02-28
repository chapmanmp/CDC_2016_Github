%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Obtain confidence interval statistics: mean, distance below mean, distance above mean.

%ASSUMPTIONS: CI denotes confidence interval.

%INPUTS: ParameterSet - matrix of parameters obtained from perturbed data sets. Format specified in 'IV. EVALUATE MODEL SENSITIVITY'.
%FractionForConfidenceInterval = 0.95 indicates that we are calculating a 95% confidence interval.

%OUTPUTS: ConfidenceIntervalStatistics = matrix of confidence interval statistics: row 1 = mean, row 2 = distance below mean, row 3 = distance above mean, col = model parameter.
%Format is specified in 'IV. EVALUATE MODEL SENSITIVITY'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ConfidenceIntervalStatistics = GetConfidenceIntervalStatistics(ParameterSet, FractionforConfidenceInterval)
[NumPerturbedDataSets, NumParameters] = size(ParameterSet);
ConfidenceIntervalStatistics = [];
NumToRemoveEachEndCI = round(NumPerturbedDataSets*(1-FractionforConfidenceInterval)/2); %5 when there are 200 bootstrap sets.
for j = 1:NumParameters
    IncreasingOrderParameterj = sort(ParameterSet(:,j)); %Sort iterations of parameter j in increasing order.
    MinCI = IncreasingOrderParameterj(NumToRemoveEachEndCI+1); %Minimum of CI
    MaxCI = IncreasingOrderParameterj(NumPerturbedDataSets-NumToRemoveEachEndCI); %Maximum of CI
    meanCI = mean([MinCI MaxCI]); DistanceFromMean = meanCI - MinCI;
    StatisticsParameterj = [meanCI, DistanceFromMean, DistanceFromMean]; %Row vector
    ConfidenceIntervalStatistics = [ConfidenceIntervalStatistics StatisticsParameterj'];
end