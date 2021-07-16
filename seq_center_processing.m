% Seq-C processing script
% Written by Jessica Goel
% Updated 7/12/21

% part 1: reading .CSV files and initializing variables
% this section of the code will read the CSV file and import it as a table
% it also initializes variables needed later on in the code

cd('\\client\c$\CAPS Lab Project')

initTable = readtable('pilotdata.csv');
filteredIndices = find(strcmp(initTable.type, 'nonnativeCC')); % change this to look at native CCs, singletons, etc. 
filteredIndices = filteredIndices';
initTable = initTable([filteredIndices],:);

i = 1;
j = 2;

platLag = [];
onsLag = [];


% part 2: calculations
% this part of the code will calculate the plateau lag and onset lag for
% % each utterance

while j <= size(initTable,1)
    relMatrix = initTable([i j],:);

    platLag = [platLag ;(relMatrix{2,9}-relMatrix{1,11})/(relMatrix{2,11}-relMatrix{1,9})];
    onsLag = [onsLag ; (relMatrix{2,7} - relMatrix{1,9})/(relMatrix{1,11} - relMatrix{1,9})];
    
    i = i + 2;
    j = j + 2;
end

meanPlatLag = mean(platLag);
meanOnsLag = mean(onsLag);

stdevPlatLag = std(platLag);
stdevOnsLag = std(onsLag);

covPlatLag = stdevPlatLag/meanPlatLag;
covOnsLag = stdevOnsLag/meanOnsLag;

% part 3: writing
% this section of the code writes the processed data to a CSV file. 

cd('\\client\c$\CAPS Lab Project') % change the directory here

finalCSV = {'Plateau Lag' platLag; 'Onset Lag' onsLag};

calcTable = {'Results', 'Plateau Lag', 'Onset Lag'; 
    'Mean', meanPlatLag, meanOnsLag; 
    'Stand. Dev.', stdevPlatLag, stdevOnsLag; 
    'Coeff. of Var.', covPlatLag,covOnsLag};

writecell(finalCSV,'Processed_Data.csv'); % change the title of the file here
writecell(calcTable,'Addl_Calculations.xlsx'); % change the title of the file here


