%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Get sample mean, sample variance at time 0. Used to generate synthetic data set.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [SampleMean, SampleVariance] = GetSampleStatistics(CompositeData, NumTimePoints)

[~, NumSamples] = size(CompositeData); NumWells = NumSamples/NumTimePoints; InitialValues = CompositeData(:,1:NumWells);

SampleMean = mean(InitialValues,2); %Take mean of each row. 

CenteredInitialValues = InitialValues - repmat(SampleMean,[1,NumWells]);

SampleCovariance = 1/NumWells*(CenteredInitialValues*CenteredInitialValues');

SampleVariance = mean(diag(SampleCovariance)); %Average variances of each state.

ReductionFactor = 1/50;

SampleVariance = SampleVariance*ReductionFactor;