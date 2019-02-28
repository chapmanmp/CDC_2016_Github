function [FittedData_AllWells] = GetFittedData_AllWells_ForBootstrap(CompositeData, NumTimePoints)

[~, NumSamples] = size(CompositeData); NumWells = NumSamples/NumTimePoints;

[DynamicsMatrix_Linear] = GetLinearModel(CompositeData, NumTimePoints);

FittedData_InitialCondition = CompositeData(:,1:NumWells); %Set initial condition of fitted data to that of composite data.

FittedData_AllWells = [FittedData_InitialCondition DynamicsMatrix_Linear*CompositeData(:,1:NumSamples-NumWells)];
%NumSamples = 24
%NumWells = 4
%Cols 1 to 20 = times 0 to 48 hours
%Col 21, 22, 23, 24 = time 60.


% %[~, RoughVarianceEstimate] = GetSampleStatistics(CompositeData, NumTimePoints);
% 
% for sample = 1:NumSamples-NumWells %Times 0 to second-to-last
%         
%         xk_Original = CompositeData(:,sample);
%         
%         %Noisek = sqrt(RoughVarianceEstimate)*randn(NumStates,1);
%         
%         %xkPLUS1_Predicted = DynamicsMatrix_Linear_FromTrainData*xk_Original + Noisek; %Must incorporate noise, as this is the model assumption!
%         
%         PredictedTestData_UsingModelFromTrainData = [PredictedTestData_UsingModelFromTrainData xkPLUS1_Predicted];
%         
% end
% 
% %sqrt(RoughVarianceEstimate)*randn(NumStates,1); 
% %Assume noise is N(0,RoughVarianceEstimate*I_NumStates) IID at each time point.
% %randn(M,N) returns an M-by-N matrix containing pseudorandom values drawn from the standard normal distribution.