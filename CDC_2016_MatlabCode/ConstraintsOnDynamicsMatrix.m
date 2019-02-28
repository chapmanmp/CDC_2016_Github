%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: List contraints to ensure a biologically-meaningful dynamics matrix in model estimation procedure.
%INPUTS: Dynamics - dynamics matrix variable that is undergoing optimization. NumStates - number of states.
%DEPENCENCIES: To be used with GetLinearModel.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ones(1,NumStates)*Dynamics >= 1; %Cell division gains must exceed 1.
       
diag(Dynamics)>= 0; %Diagonal terms must exceed 0.
       
Dynamics(:,end) == [zeros(NumStates-1,1); 1]; %Constraint on last col of dynamics matrix.
       
for j = 1:NumStates-1
    ColNonDiag = Dynamics(:,j); ColNonDiag(j) = [];  %Nondiagonal terms must be between 0 and 1.
    ColNonDiag >= 0;
    ColNonDiag <= 1;
    if j ~= 1                                        %Set all cell division gains equivalent due to S-phase data.
        sum(Dynamics(:,1)) == sum(Dynamics(:,j));
    end
end
