function MaskOptions = GetMaskOptionsForNetSwitching(NumStates)

MaskMatrix = [1 2 1 1 1 1 0 0 0 0; 2 1 0 0 0 0 1 1 1 1; 1 3 1 0 1 0 1 0 1 0; 3 1 0 1 0 1 0 1 0 1; 2 3 1 1 0 0 1 1 0 0; 3 2 0 0 1 1 0 0 1 1];
%How can I generate MaskMatrix just using NumStates?

NumNetSwitchingOptions = 2^(NumStates-1);

MaskOptions = cell(NumNetSwitchingOptions);

NumNonDiagPairs = (NumStates-1)*2;

for option = 1:NumNetSwitchingOptions %Initialize cell of mask options.
    MaskOptions{option} = -1*ones(NumStates-1,NumStates-1); 
end

for pair = 1:NumNonDiagPairs
    row = MaskMatrix(pair,1); col = MaskMatrix(pair,2); %row = ith entry of mask = 1st col of mask matrix, col = jth entry of mask = 2nd col of mask matrix
    for option = 1:NumNetSwitchingOptions
        CurrentMask = MaskOptions{option}; %Extract mask option.
        CurrentMask(row,col) = MaskMatrix(pair,option+2); %option+2 = col of mask matrix associated with mask option.
        MaskOptions{option} = CurrentMask; %Update mask option (i,j) value. 
    end
end
