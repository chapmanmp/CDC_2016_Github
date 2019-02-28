%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Import raw phenotype counts and dead cell percentages.

%ASSUMPTIONS: Conditions in order: Control, GSK, BEZ, COMBO; Spreadsheet format: 'Data_PhenotypeDeadExpts_PracticeSpreadSheetonOct5Data'

%INPUTS: path of spreadsheet, T = Number of time points, W = Number of wells, C = Number of conditions,
%Phenotype_Col1 = column assoc. with phenotype 1, Phenotype_ColLast = column assoc. with final phenotype, 
%DeathExpt_TotalCol = column assoc. with total counts from dead expt. DeathExpt_DeadCol = column assoc. with counts of dead cells

%OUTPUTS: Phenotype counts and dead cell percentages for each condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Control_PhenotypeExpt, Control_DeadExpt, GSK_PhenotypeExpt, GSK_DeadExpt, BEZ_PhenotypeExpt, BEZ_DeadExpt, COMBO_PhenotypeExpt, COMBO_DeadExpt]=GetRawData(path, T, W, C, Phenotype_Col1, Phenotype_ColLast, DeathExpt_TotalCol, DeathExpt_DeadCol)

Control_PhenotypeExpt = []; GSK_PhenotypeExpt = []; BEZ_PhenotypeExpt = []; COMBO_PhenotypeExpt = [];
Control_DeadExpt = []; GSK_DeadExpt = []; BEZ_DeadExpt = []; COMBO_DeadExpt = [];

%Import data.
LastRow = 1; %Initial condition

for time = 1:T %0 hr to 60 hr
    for condition = 1:C 
        FirstRow = LastRow + 2; LastRow = FirstRow + W - 1;
        NextPhenotypeData = xlsread(path,'Sheet1',[Phenotype_Col1, num2str(FirstRow),':', Phenotype_ColLast, num2str(LastRow)]);
        NextDeadRawData = xlsread(path,'Sheet1',[DeathExpt_TotalCol, num2str(FirstRow),':', DeathExpt_DeadCol, num2str(LastRow)]);
        NextDeadPercentage = NextDeadRawData(:,2)./NextDeadRawData(:,1);
        if condition == 1
            Control_PhenotypeExpt = [Control_PhenotypeExpt; NextPhenotypeData];
            Control_DeadExpt = [Control_DeadExpt; NextDeadPercentage];
        elseif condition == 2
            GSK_PhenotypeExpt = [GSK_PhenotypeExpt; NextPhenotypeData];
            GSK_DeadExpt = [GSK_DeadExpt; NextDeadPercentage]; 
        elseif condition == 3
            BEZ_PhenotypeExpt = [BEZ_PhenotypeExpt; NextPhenotypeData];
            BEZ_DeadExpt = [BEZ_DeadExpt; NextDeadPercentage];
        else
            COMBO_PhenotypeExpt = [COMBO_PhenotypeExpt; NextPhenotypeData];
            COMBO_DeadExpt = [COMBO_DeadExpt; NextDeadPercentage];
        end
    end
end

                