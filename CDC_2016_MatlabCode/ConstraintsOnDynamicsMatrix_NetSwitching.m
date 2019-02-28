%Enforce net constraints: (pij \in [0,1] and pji = 0) or (pji \in [0,1] and pij = 0)

ones(1,NumStates)*Dynamics >= 1; %Cell division gains must exceed 1.
       
diag(Dynamics)>= 0; %Diagonal terms must exceed 0.
       
Dynamics(:,end) == [zeros(NumStates-1,1); 1]; %Constraint on last col of dynamics matrix.

%Mask has (NumStates-1) rows and (NumStates-1) cols.
%Mask(i,j) = 0 indicates that pij is set to 0;
%Mask(i,j) = 1 indicates that pij \in [0,1]
%Mask is a net constraint possibility.
for i = 1:NumStates-1
    for j = 1:NumStates-1
        if i~=j
            if Mask(i,j)==0, 
                Dynamics(i,j) == 0;
            elseif Mask(i,j) == 1, 
                Dynamics(i,j) >= 0;
                Dynamics(i,j) <= 1;
            end
        end
    end
end

for j = 1:NumStates-1
    Dynamics(end,j) >= 0; %Death gains must be between 0 and 1
    Dynamics(end,j) <= 1;
    if j ~= 1 %Set all cell division gains equivalent due to S-phase data.
        sum(Dynamics(:,1)) == sum(Dynamics(:,j));
    end
end


       
