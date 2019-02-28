%ConfidenceIntervalStatistics = matrix of confidence interval statistics: row 1 = mean, row 2 = distance below mean, row 3 = distance above mean, col = model parameter.
%Format is specified in 'IV. EVALUATE MODEL SENSITIVITY'.


function VisualizeBootstrapResults(CIS_Control,CIS_GSK, CIS_BEZ, CIS_COMBO)

NumConditions = 4; %4 conditions are assumed in code below.

[~,NumParameters] = size(CIS_Control);

MaxY = max([CIS_Control(1,:)+CIS_Control(3,:) CIS_GSK(1,:)+CIS_GSK(3,:) CIS_BEZ(1,:)+CIS_BEZ(3,:) CIS_COMBO(1,:)+CIS_COMBO(3,:)]) + 0.25;

figure

FigureSettings;

for i = 1:NumConditions
    
    subplot(2,2,i)
    
    if i == 1
        ConfidenceIntervalStatistics = CIS_Control;
    elseif i == 2
        ConfidenceIntervalStatistics = CIS_GSK; 
    elseif i == 3
        ConfidenceIntervalStatistics = CIS_BEZ;
    else
        ConfidenceIntervalStatistics = CIS_COMBO;
    end
    
    errorbar(1:1:NumParameters, ConfidenceIntervalStatistics(1,:), ConfidenceIntervalStatistics(2,:), ConfidenceIntervalStatistics(3,:),'k+','linewidth',2);
    
    axis([0 (NumParameters+1) 0 MaxY]);
    
    if i == 1, title('Control'); ylabel('95% confidence intervals'); 
    elseif i == 2, title('MEKi'); 
    elseif i == 3, title('PI3K/mTORi'); ylabel('95% confidence intervals'); xlabel('Parameters'); 
    else title('Combination');xlabel('Parameters'); 
    end
    
    
end
