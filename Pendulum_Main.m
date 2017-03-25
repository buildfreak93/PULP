%This code drives an artificial pendulum of 0.45m length at amplitudes of
%15, 30 and 45 degrees based on the user choice.
%It generates the random neutral density filters and to plot the psychometric curve for the subjects
%12 filters are being used in the experiment and each filter would have 10 trials

clear all;
clc;

trials = 10;
range_NDF = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0];
%range_NDF = [0.1,0.2];
numDots = 5200;
moveSpeed = 3;
results = zeros(length(range_NDF),trials+1);
results(:,1) = range_NDF;
filter_value = range_NDF(1,randperm(size(range_NDF,2))); 
disp(filter_value)
NDF = filter_value(1);
MRN = input('MR Number: ','s');
pt_name = input('Patient Name: ','s');
which_eye = input('Enter 1 if right eye has cataract and 2 if the left eye has cataract: ');

for n = 1:trials*length(range_NDF)
    
    %%Get the Next NDF Value to be tested and Check whether the trails of that
    %%NDF is Completed or Not
    while n > 1
    
        %filter_value = Shuffle(filter_value); NDF = filter_value(1);
        filter_value = filter_value(1,randperm(size(filter_value,2))); NDF = filter_value(1,1);
        [results_row1,results_column1] = find(results(:,1) == NDF);
        if results(results_row1,trials+1) > 0
            continue
        elseif results(results_row1,trials+1) == 0
            break
        end
    end
    
    percent_complete = length(find(results(:,2:(trials+1)) > 0))/(trials*length(range_NDF));
    percent_complete = round(percent_complete*100);
    disp('Percent Completed:');
    disp(strcat(num2str(percent_complete),'%'));
    disp(strcat('Place the Neutral Density Filter:   ', num2str(NDF)));
    
    %Ask whether the examiner is ready or not
    check_ready = input("Did you Insert the filter? Press Y/N: ",'s');
    
    %Calling the pendulum swing motion
    if(check_ready == 'y' || check_ready == 'Y')
    commandStr ="sudo -S python try5.py";
    [status, commandOut] = system(commandStr);
    end
    
    responseGot = input('Response, If seen, enter Y. If not, enter N: ','s');
    
    %%Validate the Input Response Obtained
    while responseGot != 1 && responseGot !=2
        disp("Response stored as:");disp(responseGot);
        if length(responseGot) > 1;
            disp("Responded");
            responseGot = input('Please reinput choice. Choose W or B','s');
        elseif isempty(responseGot)
            responseGot = input('Please input a letter, Y or N','s');
        elseif responseGot == 'y' || responseGot == 'Y'
            responseGot = 1;
            break
        elseif responseGot == 'n' || responseGot == 'N'
            responseGot = 2;
            break
        else
            responseGot = input('Please input a letter, Y or N','s');
        end
    end
   
   
   %%Update the Response into the Results Array 
     [results_row2,results_column2] = find(results(:,1) == NDF);
    for i = 2:trials+1
        if results(results_row2,i) == 0
            results(results_row2,i) = responseGot;
            break
        else results(results_row2,i) ~= 0;
        end
    end
   
  %%Check whether the matrix is filled with responses or not 
    if isempty(find(results(:,trials+1)==0, 1))==1
        break
    end
    
end

 datafile = ['/home/innovation/Desktop/PULP/Data/', MRN,'.xlsx'];
 rstatus = xlswrite(datafile,results);

%% Save the Responses to a text file and generate a plot

for n=1:length(range_NDF)
    
    Percent_w(n) = length(find(results(n,:)==1))/trials;
    Percent_b(n) = length(find(results(n,:)==2))/trials;
    
    saveplace = '/home/innovation/Desktop/PULP';
    filename = strcat(saveplace,'as', '_', 'Psychometric data', '.txt');
    check_file = fopen(filename);
    
    if check_file == -1
        fid = fopen(filename, 'a+');
        fprintf(fid, 'Filter range\t Percent_W\t Percent_B\n'); % header for the file
        output = [range_NDF(n) Percent_w(n) Percent_b(n)];
        dataspacing_stim = '%2.3f\t %2.3f\t %2.3f\n';
        fprintf(fid, dataspacing_stim, output);
        fclose(fid);
    else
        fid = fopen(filename, 'a+');
        output = [range_NDF(n) Percent_w(n) Percent_b(n)];
        dataspacing_stim = '%2.3f\t %2.3f\t %2.3f\n';
        fprintf(fid, dataspacing_stim, output);
        fclose(fid);
    end
    
end

if which_eye == 1 % i.e. if the right eye has cataract
    figure(1)
    plot(range_NDF, Percent_w, 'r*-');
    grid on; axis square; xlim([min(range_NDF) max(range_NDF)]); ylim([0 1]);
    xlabel('Neutral Density Fiter Value'); ylabel('Percent of times the depth coponent was experienced on the right side');
elseif which_eye == 2 % i.e. if the left eye has cataract
    figure(1)
    plot(range_NDF, Percent_b, 'r*-');
    grid on; axis square; xlim([min(range_NDF) max(range_NDF)]); ylim([0 1]);
    xlabel('Neutral Density Fiter Value'); ylabel('Percent of times the depth coponent was experienced on the left side');
end


