%PURPOSE: Get synthetic data set for model ID, monte carlo.

function CompositeData_Synthetic = GetSyntheticData(DynamicsMatrix_SynTruth, CompositeData_Bio, NumTimePoints_Bio, NumTimePoints_Syn, NumWells_Syn)

[SampleMean_0, RoughVarianceEstimate] = GetSampleStatistics(CompositeData_Bio, NumTimePoints_Bio);
NumStates = length(SampleMean_0);

%For each well, determine a sequence of states by applying the model. Store sequence in cell entry.
SyntheticDataAllWells = cell(NumWells_Syn,1);

for well = 1:NumWells_Syn
    xk = SampleMean_0;
    SyntheticDataForWell = xk;
    for time = 1:NumTimePoints_Syn-1 %Initial condition is one time point.
        
        xkPLUS1 = DynamicsMatrix_SynTruth*xk + sqrt(RoughVarianceEstimate)*randn(NumStates,1); %Assume noise is N(0,RoughVarianceEstimate*I_NumStates) IID at each time point.
        %randn(M,N) returns an M-by-N matrix containing pseudorandom values drawn from the standard normal distribution. 
        
        if (xkPLUS1(end)-xk(end) < 0), xkPLUS1(end) = xk(end); end %Don't let dead cells decrease.

        SyntheticDataForWell = [SyntheticDataForWell xkPLUS1]; 
        
        xk = xkPLUS1;
    end
    
    SyntheticDataAllWells{well} = SyntheticDataForWell;
    
end

%Format synthetic data appropropriately for model identification procedure.
CompositeData_Synthetic = [];
for time = 1:NumTimePoints_Syn
    for well = 1:NumWells_Syn
        SyntheticDataForWell = SyntheticDataAllWells{well};
        CompositeData_Synthetic = [CompositeData_Synthetic SyntheticDataForWell(:,time)];
    end
end

% SyntheticDataAllWells = cell(10,1);
% for i = 1:10
%     SyntheticDataAllWells{i} = [0 1 2 3; i i i i];
% end
% NumTimePoints_Syn = 4; NumWells_Syn = 10;


    