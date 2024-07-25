close all
clear all
clc

% Daniel Sazhin
% 03/21/24
% Neuroeconomics Lab
% Temple University.
% StayGo 2 Project

% This code takes in the sourcedata and converts the comprehension check
% questions into bids format.


[pathstr,name,ext] = fileparts(pwd);
usedir = pathstr;
%[pathstr2,name,ext] = fileparts(usedir)
maindir = fullfile(usedir,'bids');

N = 360;
%% Comprehension Data

for subj = 1:N %37:N for each Participant after soft launch
    
    try
        
        partnum = num2str(subj,'%03.f');
        inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
        outputdir = fullfile(maindir,['sub-' partnum]);
        [n,t,data] = xlsread(inputdir_name);
        
        %% Headers
        
        use = t(1,:); % Pulls out the headers
        use2 = t(2,:); % Pulls out the headers
        headers = cell2table(use); % This turns the headers into a table format
        headers = table2array(headers);
        
        comp1_day7 = find(strcmp('e_a1.3_day7_16',data(1,:))); % Comprehension 1
        comp1_day12 = find(strcmp('e_a1.3_day12_68',data(1,:))); % Comprehension 1
        comp1_test = find(strcmp('Comp1_Check_No',data(1,:)));
        comp2_day7 = find(strcmp('e_a1.3_day7_34',data(1,:))); % Comprehension 2
        comp2_day12 = find(strcmp('e_a1.3_day12_145',data(1,:))); % Comprehension 2
        comp2_test = find(strcmp('Comp2_Check_Yes',data(1,:)));
        comp3_day7 = find(strcmp('i_a1.3_day7_75',data(1,:))); % Comprehension 3
        comp3_day12 = find(strcmp('i_a1.3_day12_86',data(1,:))); % Comprehension 3
        comp3_test = find(strcmp('Comp3_Check_No',data(1,:)));
        comp4_day7 = find(strcmp('i_a1.3_day7_101',data(1,:))); % Comprehension 4
        comp4_day12 = find(strcmp('i_a1.3_day12_115',data(1,:))); % Comprehension 4
        comp4_test = find(strcmp('Comp4_Check_Yes',data(1,:)));
        
        for ii = 1
            
            value_day7_c1 = (cell2mat(data(ii+1,comp1_day7)));
            actual_day7_c1 = 16;
            
            if isempty(value_day7_c1) == 1
                value_day7_c1 = 'n/a';
            end
            
            value_day12_c1 = (cell2mat(data(ii+1,comp1_day12)));
            actual_day12_c1 = 68;
            
            if isempty(value_day12_c1) == 1
                value_day12_c1 = 'n/a';
            end
            
            day1_decision = cell2mat(data(ii+1,comp1_test));
            
            value_day7_c2 = (cell2mat(data(ii+1,comp2_day7)));
            actual_day7_c2 = 34;
            
            if isempty(value_day7_c2) == 1
                value_day7_c2 = 'n/a';
            end
            
            value_day12_c2 = (cell2mat(data(ii+1,comp2_day12)));
            actual_day12_c2 = 145;
            
            if isempty(value_day12_c2) == 1
                value_day12_c2 = 'n/a';
            end
            
            day2_decision = cell2mat(data(ii+1,comp2_test));
            
            value_day7_c3 = (cell2mat(data(ii+1,comp3_day7)));
            actual_day7_c3 = 75;
            
            if isempty(value_day7_c3) == 1
                value_day7_c3 = 'n/a';
            end
            
            value_day12_c3 = (cell2mat(data(ii+1,comp3_day12)));
            actual_day12_c3 = 86;
            
            if isempty(value_day12_c3) == 1
                value_day12_c3 = 'n/a';
            end
            
            day3_decision = cell2mat(data(ii+1,comp3_test));
            
            value_day7_c4 = (cell2mat(data(ii+1,comp4_day7)));
            actual_day7_c4 = 101;
            
            if isempty(value_day7_c4) == 1
                value_day7_c4 = 'n/a';
            end
            
            value_day12_c4 = (cell2mat(data(ii+1,comp4_day12)));
            actual_day12_c4 = 115;
            
            if isempty(value_day12_c4) == 1
                value_day12_c4 = 'n/a';
            end
            
            day4_decision = cell2mat(data(ii+1,comp4_test));
            
            comp1 = {'1','comp1',num2str(value_day7_c1),num2str(actual_day7_c1),num2str(value_day12_c1),num2str(actual_day12_c1),day1_decision};
            comp2 = {'2','comp2',num2str(value_day7_c2),num2str(actual_day7_c2),num2str(value_day12_c2),num2str(actual_day12_c2),day2_decision};
            comp3 = {'3','comp3',num2str(value_day7_c3),num2str(actual_day7_c3),num2str(value_day12_c3),num2str(actual_day12_c3),day3_decision};
            comp4 = {'4','comp4',num2str(value_day7_c4),num2str(actual_day7_c4),num2str(value_day12_c4),num2str(actual_day12_c4),day4_decision};
            
            all_comps = [comp1;comp2;comp3;comp4];
            All_Vals_output = array2table(all_comps(1:end,:),'VariableNames', {'Trial' 'Trial_type' 'D7' 'D7_actual' 'D12' 'D12_actual' 'Decision'});
            filename = [outputdir '\beh' '\sub-' sprintf('%03d',subj)  '_task-staygo2comps_beh.tsv'];          
            writetable(All_Vals_output,filename, 'filetype','text', 'delimiter','\t') % Save file in table form
           
            
            %Sub_Vals = {value_day7_c1,value_day12_c1,value_day7_c2,value_day12_c2,value_day7_c3,value_day12_c3,value_day7_c4,value_day12_c4};
            %Actual_Vals = {actual_day7_c1,actual_day12_c1,actual_day7_c2,actual_day12_c2,actual_day7_c3,actual_day12_c3,actual_day7_c4,actual_day12_c4};
            %Percent = (Sub_Vals./Actual_Vals*100)-100;
            
            %Combine = [Sub_Vals;Actual_Vals];
            
%             All_Vals_output = array2table(Sub_Vals(1:end,:),'VariableNames', {'C1_D7' 'C1_D12' 'C2_D7' 'C2_D12', 'C3_D7', 'C3_D12', 'C4_D7', 'C4_D12'});
%             filename = [outputdir '\sub-' sprintf('%03d',subj) '_task-staygo2_comprehension_checks.tsv'];
%             writetable(All_Vals_output,filename, 'filetype','text', 'delimiter','\t') % Save file in table form
%             
%             day_decisions = [{day1_decision}, {day2_decision},{day3_decision},{day4_decision}];
%             %day_decisions = cell2table(day_decisions)
%             day_decisions = cell2table(day_decisions);
%             day_decisions.Properties.VariableNames = {'C1', 'C2', 'C3', 'C4'};
%             filename = [outputdir '\sub-' sprintf('%03d',subj) '_task-staygo2_comprehension_decisions.tsv'];
%             writetable(day_decisions,filename, 'filetype','text', 'delimiter','\t') % Save file in table form
         end

        %% Catch failed output
        
    catch ME
        disp(["subj_" subj "debug"])
    end
end






