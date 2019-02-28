function PlotFittedAndOriginalData(FittedData, OriginalData, NumWellsTotal, LengthTimeInterval, StateNames, NumWells_ToPlot, FigNum)

%Plotting "if" statements assume 4 states.

[NumStates,NumSamples] = size(OriginalData); NumTimePoints = NumSamples/NumWellsTotal;
%These constants may need to change.
NumColsPlots = 2;
NumRowsPlots = 2;

figure(FigNum)

FigureSettings;

TimeVector = 0:LengthTimeInterval:(NumTimePoints-1)*LengthTimeInterval;

for state = 1:NumStates
    
    subplot(NumRowsPlots,NumColsPlots,state);
    
    for well = 1:NumWells_ToPlot
        
        WellCols = well:NumWellsTotal:NumSamples; %Identify well cols. E.g., well 2 cols are 2:4:24 = [2 6 10 14 18 22].
        
        plot(TimeVector, OriginalData(state, WellCols),'k','linewidth',2); hold on
        
        plot(TimeVector, FittedData(state, WellCols),'-*r','linewidth',1); hold on
        
    end
    
    title(StateNames{state});
    
    if (state == 1 || state == 3), ylabel('Cell count'); end 
    
    if (state == 3 || state == 4), xlabel('Time (hr)'); end
    
    MinY = min([OriginalData(state,:) FittedData(state,:)]);
    
    MaxY = max([OriginalData(state,:) FittedData(state,:)]);
    
    axis([0 (NumTimePoints-1)*LengthTimeInterval MinY MaxY]);
    
end

legend('Original data','Fitted data');

% %Test code:
% well = 1;
% NumTestWells = 3;
% NumTimePoints = 5;
% ExtractColsForWell = [];
% for time = 1:NumTimePoints, ExtractColsForWell = [ExtractColsForWell, well + (time-1)*NumTestWells]; end

