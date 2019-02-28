%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Computes a random dynamics matrix inside the constraint set.
%Need to check that all diagonal terms are nonnegative in main script. This code does not guarantee this in order to keep cell division not too large.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function RandomA = GetRandomDynamicsMatrix(NumStates)

A = zeros(NumStates,NumStates); A(end,end) = 1; %Last col.
for i = 1:NumStates %Compute off-diagonal terms.
    for j = 1:NumStates-1
        if (i~=j), A(i,j) = rand(1); end
    end
end

CellDivGain = max(ones(1,NumStates)*A);

for j = 1:NumStates-1 %Cell division gains are equivalent.
    A(j,j) = CellDivGain - sum(A(:,j));
end
    
RandomA = A;