% Processing script for .LAB files 
% Written by: Jessica Goel
% Last updated: 6/20/21

% part 1: initial conditions
% this section of the code sets the directory and defines the experimental
% conditions. use the pwd command to set the directory. 
cd('\\client\c$\CAPS Lab Project');
expConditions = ["*_E_" "*_a_" "*_t_" "*_d_" "*_syllable1_" "*_syllable2_" "*_normal" "*_fast"];

% part 2: pulling apart data
% this first loop defines which experimental condition will be analyzed and
% sets up the empty vectors needed for later calculations
for i = 1:length(expConditions)
string = char([expConditions(i) "*.lab"]);
labFiles = dir(string);
numFiles = length(labFiles);

JVC = [];
TTLat = [];
RelLat = [];
PhaseAng = [];
% part 3a: reading .lab files
% this second loop begins by reading the specified .lab files
    for j = 1:numFiles
        name = labFiles(j).name;
        load = detectImportOptions(name,'FileType','text'); 
        load.DataLines = [1 7];
        lab = readcell(name,load);
% part 3b: calculations and analysis
% this section of the loop calculates JVC, TTLat, and RelLat, as well as
% extracts the Phase Angle from each .lab file, and then calculates the
% mean, standard deviation, and coefficient of variation for each value.
        JVC = [JVC; (lab{7,3} - lab{2,3})];
        TTLat = [TTLat; (lab{4,3} - lab{2,3})];
        RelLat = [RelLat; (TTLat/JVC)];
        PhaseAng = [PhaseAng; lab{4,5}];
        meanPhaseAng = mean(PhaseAng);
        
        meanJVC = mean(JVC);
        meanTTLat = mean(TTLat);
        meanRelLat = mean(RelLat);

        stdPhaseAng = std(PhaseAng);
        stdJVC = std(JVC);
        stdTTLat = std(TTLat);
        stdRelLat = std(RelLat);

        cvPhaseAng = meanPhaseAng/stdPhaseAng;
        cvJVC = meanJVC/stdJVC;
        cvTTLat = meanTTLat/stdTTLat;
        cvRelLat = meanRelLat/stdRelLat;  
% part 3c: saving
% this section of the loop writes the data for the experimental condition 
% being analyzed to a single Excel spreadsheet. use the pwd command to set
% the directory. 
        finalCell = {i, 'Phase Angle', 'Jaw Vowel Cycle' 'Tongue Tip Latency', 'Relative Latency';
            'Mean', meanPhaseAng, meanJVC, meanTTLat, meanRelLat;
            'Standard Deviation', stdPhaseAng, stdJVC, stdTTLat, stdRelLat;
            'Coefficient of Variation', cvPhaseAng, cvJVC, cvTTLat, cvRelLat};
        
        cd('\\client\c$\CAPS Lab Project')
        writecell(finalCell,'Table_%f.xlsx,',i);
    end
end








