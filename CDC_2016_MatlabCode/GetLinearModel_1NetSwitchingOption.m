function [Error, DynamicsMatrix_LinearModel_NetSwitching] = GetLinearModel_1NetSwitchingOption(CompositeData,NumTimePoints,Mask)

%Mask is in "ConstraintsOnDynamicsMatrix_NetSwitching", used to specify net switching possibility.

[XPRE, XPOST] = GetDataMatricesForModelEstimation(CompositeData,NumTimePoints);

NumStates = size(XPRE,1);

cvx_begin
    variable Dynamics(NumStates,NumStates)
    minimize (norm(XPOST - Dynamics*XPRE,'fro'))
    subject to
       ConstraintsOnDynamicsMatrix_NetSwitching;
cvx_end

DynamicsMatrix_LinearModel_NetSwitching = Dynamics;

Error = cvx_optval;