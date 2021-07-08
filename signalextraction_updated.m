% Extracting and processing the positions of the sensors
% Written by: Jessica Goel
% Updated May 5th, 2021

% part 1: setting the directory
% use the pwd command to find the directory whose data you want to process
cd('/Volumes/projects/CAPS/research_projects/deaf_ema/EMA-CI-interference-analysis/Susan_test_CI_EMA_with_CI/MAT');

% part 2: initializing variables
% this section of the code finds all of the .mat files in the directory and
% declares empty matrices for mean, standard deviation, and coefficient of
% variation
matFiles = dir('*.mat');
numfiles = length(matFiles);
Mean = [];
Standard_Dev = [];
CoEffVar = [];

% part 3: calculations

for i = 1:numfiles
    % part 3a: conversions
    % this part of the code converts the name of the .mat file into a line
    % of code that can be indexed, and declares an empty distance matrix
    name = matFiles(i).name;
    name = name(1:end-4);
    load(name)
    name = eval(name);
    distance = [];
    % part 3b: distances
    % this part of the code calculates the distance between each sensor
    % pair
  for j = 2:6
      for k = 2:6
          if j ~= k
              xdist = (name(j).SIGNAL(:,1)-name(k).SIGNAL(:,1)).^2;
              ydist = (name(j).SIGNAL(:,2)-name(k).SIGNAL(:,2)).^2;
              zdist = (name(j).SIGNAL(:,3)-name(k).SIGNAL(:,3)).^2;
              dist = sqrt(xdist+ydist+zdist);
              distance = [distance dist];
          else
              continue 
          end
      end
  end
  % part 3c: further processing
  % this part of the code calculates the mean, standard deviation, and
  % coefficient of variation, as well as extracts the relevant mean and
  % standard deviation values.
  M = mean(distance);
  M = M';
  M = M([11 12 16]);
  
  Mean = [Mean M];
  
  SD = std(distance);
  SD = SD';
  SD = SD([11 12 16]);
              
  Standard_Dev = [Standard_Dev SD];
  
  CV = M./SD;
  
  CoEffVar = [CoEffVar CV];
end 

% part 4: grand totals
% this section of code calculates the mean across all trials for each
% sensor pair

Mean = Mean';
Mean = mean(Mean);
Mean = Mean';

Standard_Dev = Standard_Dev';
Standard_Dev = mean(Standard_Dev);
Standard_Dev = Standard_Dev';

% part 5: saving
% this part of the code saves the matrices into excel spreadsheets inside
% the specified directory

cd('/Volumes/projects/CAPS/research_projects/deaf_ema/EMA-CI-interference-analysis/Susan_test_CI_EMA_with_CI/');
writematrix(Mean, 'Mean.xls');
writematrix(Standard_Dev, 'Standard_Deviation_2.xls');
writematrix(CoEffVar, 'Coefficient_of_Variation.xls');





