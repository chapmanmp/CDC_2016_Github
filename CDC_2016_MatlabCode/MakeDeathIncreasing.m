function CompositeData_DeathInc = MakeDeathIncreasing(CompositeData, NumTimePoints)

CompositeData_DeathInc = CompositeData; %Initialize composite data death increasing.

[~,NumSamples] = size(CompositeData);

NumWells = NumSamples/NumTimePoints;

for well = 1:NumWells
    
    WellCols = well:NumWells:NumSamples; %Identify well cols. E.g., well 2 cols are 2:4:24 = [2 6 10 14 18 22].
    
    for time = 1:NumTimePoints-1
        
        WellCol_kPLUS1 = WellCols(time+1); 
        
        WellCol_k = WellCols(time);
        
        DeadCells_kPLUS1 = CompositeData_DeathInc(end,WellCol_kPLUS1); %Extract dead cells from specified well at time k + 1.
        
        DeadCells_k = CompositeData_DeathInc(end,WellCol_k); %Extract dead cells from specified well at time k.
        
        if (DeadCells_kPLUS1 - DeadCells_k < 0) %if dead cells decrease, make them stay constant over interval.
            
            CompositeData_DeathInc(end,WellCol_kPLUS1) = DeadCells_k;
        
        end
    end
end

