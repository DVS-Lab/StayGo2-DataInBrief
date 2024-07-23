clear all;
close all;
clc;

% Daniel Sazhin
% 03/23/24
% Neuroeconomics Lab
% Temple University.
% StayGo 2 Project

% This code takes in raw sourcedata and extracts the survey data

% PROMIS, EcoG, 7Up7Down, ABIS, DOSPERT, SES, Loneliness

[pathstr,name,ext] = fileparts(pwd);
usedir = pathstr;
%rootdir = fileparts(usedir);
%[pathstr2,name,ext] = fileparts(usedir)
maindir = fullfile(usedir,'bids');
outputdir = fullfile(usedir,'bids');
codedir = fullfile(usedir,'code');

N = 360; % For total Participants

%% Loneliness Questionnaire

fname = sprintf('loneliness_questionnaire.tsv'); % making compatible with bids output
output = fullfile(usedir,'bids','phenotype',fname);

if ~exist(output)
    delete(output)
end

myfile = fullfile(output);
fid = fopen(myfile,'w');
fprintf(fid,'participant_id\tloneliness_q1\tloneliness_q2\tloneliness_q3\n');
%fclose(fid);
    
for ii = 1:N %1:N % for each Participant
    
    try
        
    partnum = num2str(ii,'%03.f');
    inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
    [n,t,data] = xlsread(inputdir_name);
    
    %% Loneliness
    
    start = find(strcmp('Loneliness_1',data(1,:)));
    finish = find(strcmp('Loneliness_3',data(1,:)));
    T = 3; % Number of questions
    IndexedColumns = round(linspace(start,finish, T));
    Loneliness_Data = data(:,IndexedColumns); % Save them
    
    % Convert text into values
    
    [~,T]= size(Loneliness_Data);
    Output_Loneliness_Data  = [];

    for kk = 1:T
        
        question = data(2,IndexedColumns(kk));
        
        HardlyEver = cell2mat(strfind(question,'Hardly Ever','ForceCellOutput',true))*1;
        Sometimes = cell2mat(strfind(question,'Some of the time','ForceCellOutput',true))*2;
        Often = cell2mat(strfind(question,'Often','ForceCellOutput',true))*3;
        
        result = [HardlyEver, Sometimes, Often];
        
        Output_Loneliness_Data = [Output_Loneliness_Data, result];
        %Output_Loneliness_Data = [subname,Output_Loneliness_Data]
        
    end
    
    Loneliness = Output_Loneliness_Data;
    %subname = (cellstr(['sub-' partnum]);
    %row = [subname, Loneliness];

    %myfile = fullfile(output);
    
    fprintf(fid,'%s\t%f\t%f\t%f\n',['sub-' partnum], Loneliness);

    catch ME
        disp(["subj_" ii "debug" "Loneliness Questionnaire"])
    end
end

fclose(fid);

%% 7Up7Down

fname = sprintf('sevenup_sevendown_questionnaire.tsv'); % making compatible with bids output
output = fullfile(usedir,'bids','phenotype',fname);

if ~exist(output)
    delete(output)
end

myfile = fullfile(output);
fid = fopen(myfile,'w');
fprintf(fid,'participant_id\tsusd_q1\tsusd_q2\tsusd_q3\tsusd_q4\tsusd_q5\tsusd_q6\tsusd_q7\tsusd_q8\tsusd_q9\tsusd_q10\tsusd_q11\tsusd_q12\tsusd_q13\tsusd_q14\n');
%fclose(fid);
    
for ii = 1:N %1:N % for each Participant
    
    try
        
    partnum = num2str(ii,'%03.f');
    inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
    [n,t,data] = xlsread(inputdir_name);
 
    start = find(strcmp('7up7down_1',data(1,:))); % Find the 7up7down 1 column,
    finish = find(strcmp('7up7down_14',data(1,:))); % Find the 7up7down 12 column.
    T = 14; % Number of questions
    IndexedColumns = round(linspace(start,finish, T)); % Index all of the SevenUp columns.
    SevenUpSevenDown_data = data(:,IndexedColumns); % Save them

    % Convert text into values
    
    [~,T]= size(SevenUpSevenDown_data);
   % Output_SevenUpSevenDown_Data  = [];
    
    Output_SevenUpSevenDown_Data = strrep(SevenUpSevenDown_data,'Never or hardly ever','0');
    Output_SevenUpSevenDown_Data = strrep(Output_SevenUpSevenDown_Data,'Sometimes','1');
    Output_SevenUpSevenDown_Data = strrep(Output_SevenUpSevenDown_Data,'Often','2');
    Output_SevenUpSevenDown_Data = strrep(Output_SevenUpSevenDown_Data,'Very often or almost constantly','3');
    
    result = str2double(Output_SevenUpSevenDown_Data(2,:));
    
    fprintf(fid,'%s\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',['sub-' partnum], result);

    catch ME
        disp(["subj_" ii "debug" "7up7Down Questionnaire"])
    end
end

fclose(fid);

%% PROMIS

fname = sprintf('promis_questionnaire.tsv'); % making compatible with bids output
output = fullfile(usedir,'bids','phenotype',fname);

if ~exist(output)
    delete(output)
end

myfile = fullfile(output);
fid = fopen(myfile,'w');
fprintf(fid,'participant_id\tPROMIS_q1\tPROMIS_q2\tPROMIS_q3\tPROMIS_q4\tPROMIS_q5\tPROMIS_q6\tPROMIS_q7\tPROMIS_q8\n');
%fclose(fid);
    
for ii = 1:N %1:N % for each Participant
    
    try
        
    partnum = num2str(ii,'%03.f');
    inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
    [n,t,data] = xlsread(inputdir_name);
 
    start = find(strcmp('PROMIS_1',data(1,:))); % Find the 7up7down 1 column,
    finish = find(strcmp('PROMIS_8',data(1,:))); % Find the 7up7down 12 column.
    T = 8; % Number of questions
    IndexedColumns = round(linspace(start,finish, T)); % Index all of the SevenUp columns.
    PROMIS_data = data(:,IndexedColumns); % Save them

    % Convert text into values
    
    [~,T]= size(PROMIS_data);
   % Output_SevenUpSevenDown_Data  = [];
    
    Output_PROMIS_Data = strrep(PROMIS_data,'Never','1');
    Output_PROMIS_Data = strrep(Output_PROMIS_Data,'Rarely','2');
    Output_PROMIS_Data = strrep(Output_PROMIS_Data,'Sometimes','3');
    Output_PROMIS_Data = strrep(Output_PROMIS_Data,'Often','4');
    Output_PROMIS_Data = strrep(Output_PROMIS_Data,'Always','5');
    
    result = str2double(Output_PROMIS_Data(2,:));
    
    fprintf(fid,'%s\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',['sub-' partnum], result);

    catch ME
        disp(["subj_" ii "debug" "PROMIS Questionnaire"])
    end
end

fclose(fid);

%% ABIS

fname = sprintf('abbreviated_impulsiveness_scale.tsv'); % making compatible with bids output
output = fullfile(usedir,'bids','phenotype',fname);

if ~exist(output)
    delete(output)
end

myfile = fullfile(output);
fid = fopen(myfile,'w');
fprintf(fid,'participant_id\tABIS_q1\tABIS_q2\tABIS_q3\tABIS_q4\tABIS_q5\tABIS_q6\tABIS_q7\tABIS_q8\tABIS_q9\tABIS_q10\tABIS_q11\tABIS_q12\tABIS_q13\n');
%fclose(fid);
    
for ii = 1:N %1:N % for each Participant
    
    try
        
    partnum = num2str(ii,'%03.f');
    inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
    [n,t,data] = xlsread(inputdir_name);
 
    start = find(strcmp('ABIS_1',data(1,:))); % Find the 7up7down 1 column,
    finish = find(strcmp('ABIS_13',data(1,:))); % Find the 7up7down 12 column.
    T = 13; % Number of questions
    IndexedColumns = round(linspace(start,finish, T)); % Index all of the SevenUp columns.
    ABIS_data = data(:,IndexedColumns); % Save them

    % Convert text into values
    
    [~,T]= size(ABIS_data);
   % Output_SevenUpSevenDown_Data  = [];
    
    Output_ABIS_Data = strrep(ABIS_data,'Rarely/Never','1');
    Output_ABIS_Data = strrep(Output_ABIS_Data,'Occasionally','2');
    Output_ABIS_Data = strrep(Output_ABIS_Data,'Often','3');
    Output_ABIS_Data = strrep(Output_ABIS_Data,'Almost Always/Always','4');
    
    result = str2double(Output_ABIS_Data(2,:));
    
    fprintf(fid,'%s\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',['sub-' partnum], result);

    catch ME
        disp(["subj_" ii "debug" "ABIS Questionnaire"])
    end
end

fclose(fid);

%% ECoG

fname = sprintf('everyday_cognition_questionnaire.tsv'); % making compatible with bids output
output = fullfile(usedir,'bids','phenotype',fname);

if ~exist(output)
    delete(output)
end

myfile = fullfile(output);
fid = fopen(myfile,'w');
fprintf(fid,'participant_id\tEcog_q2\tEcog_q3\tEcog_q4\tEcog_q5\tEcog_q6\tEcog_q7\tEcog_q8\tEcog_q9\tEcog_q10\tEcog_q12\tEcog_q13\tEcog_q14\n'); % Qualtrics data starts at Ecog 2. Ecog 11 is an attention check.
%fclose(fid);
    
for ii = 1:N %1:N % for each Participant
    
    result = [];
    try
        
    partnum = num2str(ii,'%03.f');
    inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
    [n,t,data] = xlsread(inputdir_name);
 
    start = find(strcmp('Ecog_2',data(1,:))); 
    finish = find(strcmp('Ecog_14',data(1,:))); 
    T = 13; % umber of questions
    IndexedColumns = round(linspace(start,finish, T));
    Ecog_data = [data(:,IndexedColumns(1:9)), data(:,IndexedColumns(11:13))]; % Exclude attention check (10th index)
    Ecog_data = cellfun(@num2str,Ecog_data,'UniformOutput',0); % turn NaNs into strings.
    
    Output_Ecog_Data = strrep(Ecog_data,'Better or no change','1');
    Output_Ecog_Data = strrep(Output_Ecog_Data,'A little worse sometimes','2');
    Output_Ecog_Data = strrep(Output_Ecog_Data,'A little worse all the time','3');
    Output_Ecog_Data = strrep(Output_Ecog_Data,'Much worse','4');
    Final_Output_Ecog_Data = strrep(Output_Ecog_Data, 'NaN','999'); % Later eliminate these questions from total tally per scoring instructions.
    
    result = str2double(Final_Output_Ecog_Data(2,:));
    
    %myfile = fullfile(output);
    %fid = fopen(myfile,'w');
    fprintf(fid,'%s\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',['sub-' partnum], result);

    catch ME
        disp(["subj_" ii "debug" "Ecog Questionnaire"])
    end
end

fclose(fid);

%% DOSPERT

fname = sprintf('domain_specific_risk_taking_scale.tsv'); % making compatible with bids output
output = fullfile(usedir,'bids','phenotype',fname);

if ~exist(output)
    delete(output)
end

myfile = fullfile(output);
fid = fopen(myfile,'w');
fprintf(fid,'participant_id\tethRT_q1\tethRT_q2\tethRT_q3\tethRT_q4\tethRT_q5\tethRT_q6\tfinRT_q1\tfinRT_q2\tfinRT_q3\tfinRT_q4\tfinRT_q5\tfinRT_q6\theaRT_q1\theaRT_q2\theaRT_q3\theaRT_q4\theaRT_q5\theaRT_q6\trecRT_q1\trecRT_q2\trecRT_q3\trecRT_q4\trecRT_q5\trecRT_q6\tsocRT_q1\tsocRT_q2\tsocRT_q3\tsocRT_q4\tsocRT_q5\tsocRT_q6\n'); % Qualtrics data starts at Ecog 2. Ecog 11 is an attention check.
%fclose(fid);
    
for ii = 1:N %1:N % for each Participant
    
    result = [];
    
    try
        
    partnum = num2str(ii,'%03.f');
    inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
 
    start = find(strcmp('ethRT_1',data(1,:))); 
    finish = find(strcmp('socRT_6',data(1,:))); 
    T = 30; % umber of questions
    IndexedColumns = round(linspace(start,finish, T));
    DOSPERT_data = data(:,IndexedColumns(1:end));
    
    Output_DOSPERT_Data = strrep(DOSPERT_data,'Extremely Unlikely','1');
    Output_DOSPERT_Data = strrep(Output_DOSPERT_Data,'Moderately Unlikely','2');
    Output_DOSPERT_Data = strrep(Output_DOSPERT_Data,'Somewhat Unlikely','3');
    Output_DOSPERT_Data = strrep(Output_DOSPERT_Data,'Not Sure','4');
    Output_DOSPERT_Data = strrep(Output_DOSPERT_Data,'Somewhat Likely','5');
    Output_DOSPERT_Data = strrep(Output_DOSPERT_Data,'Moderately Likely','6');
    Output_DOSPERT_Data = strrep(Output_DOSPERT_Data,'Extremely Likely','7');

    result = str2double(Output_DOSPERT_Data(2,:));
    
    %myfile = fullfile(output);
    %fid = fopen(myfile,'w');
    fprintf(fid,'%s\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',['sub-' partnum], result);

    catch ME
        disp(["subj_" ii "debug" "DOSPERT Questionnaire"])
    end
end

fclose(fid);

%% Participants

%filedir = fullfile(codedir,'ortega_parameters_all_zipcodes.xls');
[f,~,data1] = xlsread('ortega_parameters_all_zipcodes.xls');

fname = sprintf('participants.tsv'); % making compatible with bids output
output = fullfile(outputdir,fname);

if ~exist(output)
    delete(output)
end

myfile = fullfile(output);
fid = fopen(myfile,'w');
fprintf(fid,'participant_id\tEducation\tAge\tGender\tRace\tEthnicity\tZipcode\tWhen_Move\tCurrent_City\tCurrent_State\tTotal_Income\tPersonal_Income\tRent\tHousehold_Members\tEducation_ses\tYears_Education\tLadder\tOccupation_1\tOccupation_2\tAlpha\tGamma\n'); 
%fclose(fid);

for ii = 10 % for each Participant
    
    result = [];
    
   
        
        partnum = num2str(ii,'%03.f');
        inputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]),(['sub-' partnum '.xlsx']));
        [n,t,data] = xlsread(inputdir_name);
        
        start = find(strcmp('Age',data(1,:)));
        finish = find(strcmp('current_state_1',data(1,:)));
        T = 10; % Number of questions
        IndexedColumns = round(linspace(start-1,finish, 9)); % Ignore DQ.
        demo_data = data(:,IndexedColumns(1:end));
        
        start2 = find(strcmp('total income',data(1,:)));
        finish2 = find(strcmp('Occupation_2',data(1,:)));
        T = 9; % Number of questions
        IndexedColumns = round(linspace(start2,finish2, 9));
        ses_data = data(:,IndexedColumns(1:end));
        
        result = string([demo_data(2,:),ses_data(2,:)]);
        
        if ismissing(result(9))
            result(9) = "n/a";
        end
        
        zipcode_test = str2num(result(6));
        k = find(f(:,1)==zipcode_test);
        alpha = f(k(1),end-1);
        omega = f(k(1),end);
        add_these = num2str(alpha);
        add_these2 = num2str(omega);
        result = [result,add_these];
        result = [result,add_these2];
        
       % test = cellfun(@(result) strcmp(result, 'NaN'), result)

        
        fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',['sub-' partnum], result);
        
    %catch ME
    %    disp(["subj_" ii "debug" "Participant.tsv"])
    %end
end

fclose(fid);

    