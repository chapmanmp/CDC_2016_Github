%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Compute the dynamics matrix using the input data and least-squares optimization with constraints.

%ASSUMPTIONS: Phenotype dynamics are well-represented by a deterministic
%linear time-invariant model; ConstraintsOnDynamicsMatrix requires optimization argument to be called Dynamics, and number of states to be defined as NumStates.

%INPUTS: CompositeData - contains all time points, all phenotypes + dead cells (Number of wells need not be specified);
%NumTimePoints - number of time points.

%OUTPUTS: Dynamics matrix, format specified in 'III. VALIDATE MODEL.'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [DynamicsMatrix_LinearModel] = GetLinearModel(CompositeData,NumTimePoints)

[XPRE, XPOST] = GetDataMatricesForModelEstimation(CompositeData,NumTimePoints);

NumStates = size(XPRE,1);

cvx_begin
    variable Dynamics(NumStates,NumStates)
    minimize (norm(XPOST - Dynamics*XPRE,'fro'))
    subject to
       ConstraintsOnDynamicsMatrix
cvx_end

DynamicsMatrix_LinearModel = Dynamics;