function PlotBasalCompositeData(Control_CompositeData, GSK_CompositeData, BEZ_CompositeData, COMBO_CompositeData, NumTimePoints, LengthTimeInterval)

NumConditions = 4;

ConditionNames = cell(4,1);

ConditionNames{1} = 'Control'; ConditionNames{2} = 'MEKi'; ConditionNames{3} = 'PI3K/mTORi'; ConditionNames{4} = 'Combination';

TimeVector = 0:LengthTimeInterval:(NumTimePoints-1)*LengthTimeInterval;

[~,NumSamples] = size(Control_CompositeData); NumWells = NumSamples/NumTimePoints;

BasalState = 1;

PlotStyle = cell(4,1);

PlotStyle{1} = 'k'; PlotStyle{2} = '-.k'; PlotStyle{3} = 'r'; PlotStyle{4} = '-.r';

figure

FigureSettings;

for i = 1:NumConditions
    
    subplot(2,2,i);
    
    if i == 1, CompositeData = Control_CompositeData;
    elseif i == 2, CompositeData = GSK_CompositeData;
    elseif i == 3, CompositeData = BEZ_CompositeData;
    else CompositeData = COMBO_CompositeData; 
    end
    
    for well = 1:NumWells
        
        WellCols = well:NumWells:NumSamples;
        
        plot(TimeVector, CompositeData(BasalState, WellCols),PlotStyle{well},'linewidth',2); hold on
                
    end
    
    MinY = min(CompositeData(BasalState,:));
    
    MaxY = max(CompositeData(BasalState,:));
       
    axis([0 TimeVector(end) MinY MaxY]);
    
    title(ConditionNames{i});
    
    if (i == 1 || i == 3), ylabel('Green cell counts'); end
    
    if (i == 3 || i == 4), xlabel('Time (hr)'); end
    
end

%legend('Rep. well w','Rep. well x','Replicate well y', 'Replicate well z');
    
        
