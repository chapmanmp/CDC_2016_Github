%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMPLEMENT WILD BOOTSTRAP
%ASSUMPTIONS: Measurement error is independent of cell type (i.e., phenotype or dead), conditioned on time and well. 
%Time 0 values of fitted and bootstrap sets are the same, since time 0 is the initial condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function BootstrapSet = ComputePerturbedDataSet_WildBootstrap(CompositeData,FittedData,NumTimePoints)

%CompositeData = data set derived from experimental observations, all wells
%FittedData = fitted data, all wells

AbsError = abs(CompositeData - FittedData);

[NumStates, NumSamples] = size(CompositeData); NumWells = NumSamples/NumTimePoints;

BootstrapSet = FittedData; %Initialize bootstrap set to the fitted set.

for col = NumWells+1:NumSamples
    %NumWells = 4
    %NumWells + 1 = 5, time 12 hours in well 1
    %NumSamples = 24, time 60 hours in well 4
    %Keep bootstrap set = fitted set at time 0, all wells.
    
    for state = 1:NumStates
        
        ChooseSign = binornd(1,1/2); %Returns 0 or 1 with equal probability. 1 = Number of trials, 1/2 = Probability of success.
                
        BootstrapSet(state,col) = BootstrapSet(state,col) + ((ChooseSign == 1)-(ChooseSign == 0))*AbsError(state,col); %Sign on error is either + or - with equal probability.     
    
    end  
    
end