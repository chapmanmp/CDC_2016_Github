function BestDynamics_NetSwitching = GetBestLinearModel_NetSwitching(CompositeData,NumTimePoints)

[NumStates,~] = size(CompositeData);

MaskOptions = GetMaskOptionsForNetSwitching(NumStates);

BestError_NetSwitching = 10^4; %Initialize best error to a very high amount.

for option = 1:length(MaskOptions)
    Mask = MaskOptions{option}; %Get mask.
    [Error_NetSwitching, DynamicsMatrix_LinearModel_NetSwitching] = GetLinearModel_1NetSwitchingOption(CompositeData,NumTimePoints,Mask); %Identify dynamics under net swiching constraints specified by mask.
    if (Error_NetSwitching < BestError_NetSwitching) %Are these net switching constraints the best?
        BestError_NetSwitching = Error_NetSwitching;
        BestDynamics_NetSwitching = DynamicsMatrix_LinearModel_NetSwitching;
    end
end

