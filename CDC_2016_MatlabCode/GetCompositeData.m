%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PURPOSE: Compute composite data set for mathematical model, using original data from phenotype and dead experiments.

%ASSUMPTIONS: Format of inputs as specified in "I. IMPORT DATA"; Percentage of dead cells in well w, time t is removed from each phenotype count
%in well w, time t. The sum of all cells removed is the estimated total number of dead cells in well w, time t.

%INPUTS: Condition_PhenotypeExpt - contains original phenotype counts for all wells, all time points for a particular condition;
%Condition_DeadExpt - contains dead cell percentages for all wells, all time points for the condition. 
%Format of these arguments is specified in 'I. IMPORT DATA'.

%OUTPUT: Matrix, ROWS: Phenotype quantities (all except last), Dead cell quantities (last); COLUMNS: Times 0 thru 60 hrs, clustered by well number.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function CompositeData = GetCompositeData(Condition_PhenotypeExpt,Condition_DeadExpt)

Phenotypes = Condition_PhenotypeExpt';
[P,S] = size(Phenotypes); %P = number of phenotypes, S = #wells*#time points (SAMPLES)

CompositeData = zeros(P+1,S); %Need additional row for dead cells.
for i = 1:P
    CompositeData(i,:) = (ones(1,S) - Condition_DeadExpt').*Phenotypes(i,:); 
end
CompositeData(end,:) = sum(Phenotypes).*Condition_DeadExpt'; %Sum counts number of total cells measured in phenotype expt, at each time point and each well.