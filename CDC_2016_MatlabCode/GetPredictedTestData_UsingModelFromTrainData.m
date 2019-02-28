function FittedData = FitGivenDataToGivenLinearModelEstimate(DynamicsMatrixEstimate_Given, CompositeData_Given, NumWells_Given)

[~, NumSamples_Given] = size(CompositeData_Given);

FittedData = CompositeData_Given(:,1:NumWells_Given); %Time 0 hrs.

for sample = 1:NumSamples_Given-NumWells_Given %Times 0 to second-to-last
        
        xk_Original = CompositeData_Given(:,sample);
        
        xkPLUS1_Fitted = DynamicsMatrixEstimate_Given*xk_Original; %Noise not here. This formulation assumes dynamics matrix is an estimate.
        
        FittedData = [FittedData xkPLUS1_Fitted];
        
end