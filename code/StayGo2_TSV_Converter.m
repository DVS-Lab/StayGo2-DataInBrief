clear all;
close all;
clc;

[pathstr,name,ext] = fileparts(pwd);
usedir = pathstr;
%[pathstr2,name,ext] = fileparts(usedir)
maindir = fullfile(usedir,'bids','sourcedata');
outputdir = fullfile(usedir,'bids');

N = 360;% For total Participants

r = 1; % only one run.

All_Bad_Trials  = [];

for subj = 1:N % 37:N for each Participant with response time data and after soft launch
    
   % try
        
    partnum = num2str(subj,'%03.f');
    inputdir_name = fullfile(maindir,(['sub-' partnum]),(['sub-' partnum]));
    [n,t,data] = xlsread(inputdir_name);
    
    % Daniel Sazhin
    % 03/15/24
    % Neuroeconomics Lab
    % Temple University.
    % StayGo 2 Project
    
    % This code takes in raw sourcedata and converts it to a TSV format
    
    % Trial Number, phase, response time, onset, Tokens, Alpha Value, Exponential, Tokens Turn before, Alpha
    % Value, Correct, Earnings, Stay or Go
    
    % Phase: Endowment, Decision, Feedback,
    
    %% Headers
    
    use = t(1,:); % Pulls out the headers
    use2 = t(2,:); % Pulls out the headers
    headers = cell2table(use); % This turns the headers into a table format
    headers = table2array(headers);
    
    %% Exponential Behavioral data
    
    % For exponentials
    
    % Specify trial type
    % Determine turn left.
    % Is correct decision or not? If not, earnings 0
    % If decision correct, then what turn?
    % If turn 1,2,3,4,5,6 then earnings =.
    % Save exponential/inverse, final value, alpha, turn left, correct/incorrect, earnings
    
    % Now we need to add trial number.
    
    
    % For trial number
    % Find name
    % Use name to define extraction.
    
    % 1. Extract Learn More Decision.
    
    % 2. Extract Leave or Stay Decision.
    
    % 3. Extract Feedback phase
    
    %%
    
    Full_Participant = [];
    Record_Bad_Trial = [];
    all_blocks = ["e_127_a1.2", "e_166_a1.4", "e_78_a1.2", "e_59_a1.4", "i_88_a1.2", "i_113_a1.2", "i_116_a1.4", "i_84_a1.4"]; % "i_84_a1.4",
    %all_blocks = ["i_116_a1.4"]; % "i_84_a1.4",
    
    
    for zz = 1:length(all_blocks)
        indices = [];
        teststr = all_blocks(zz);
        k = strfind(data(1,:),teststr,'ForceCellOutput',true);
        
        for ll = 1:length(k)
            value = cell2mat(k(ll));
            saverow = [];
            if value > 0
                saverow = ll;
            end
            indices = [indices,saverow];
        end
        
        v1 = strfind(headers(indices),'v1','ForceCellOutput',true);
        v2 = strfind(headers(indices),'v2','ForceCellOutput',true);
        v3 = strfind(headers(indices),'v3','ForceCellOutput',true);
        
        v1_indices =[];
        v2_indices =[];
        v3_indices =[];
        
        for ll = 1:length(v1)
            value = cell2mat(v1(ll));
            saverow = [];
            if value > 0
                saverow = ll;
            end
            v1_indices = [v1_indices,saverow];
        end
        
        for ll = 1:length(v2)
            value = cell2mat(v2(ll));
            saverow = [];
            if value > 0
                saverow = ll;
            end
            v2_indices = [v2_indices,saverow];
        end
        
        for ll = 1:length(v3)
            value = cell2mat(v3(ll));
            saverow = [];
            if value > 0
                saverow = ll;
            end
            v3_indices = [v3_indices,saverow];
        end
        
        v1_full = indices(v1_indices);
        v2_full = indices(v2_indices);
        v3_full = indices(v3_indices);
        
        %% Go through all three versions
        
        version_nums = 1:3;
        Round_participant = [];
        
        for yy = 1:length(version_nums)
            
            if yy == 1
                version = v1_full;
            end
            
            if yy == 2
                version = v2_full;
            end
            
            if yy == 3
                version = v3_full;
            end
            
            LEARN_indices = [];
            
            for kk = 1:length(version)
                test_index = version(kk);
                responses = data(2,test_index);
                responses_result = cell2mat(responses);
                
                if isnan(responses_result) == 1
                    responses_result = 'ignore';
                end
                
                if isnumeric(responses_result) == 1
                    responses_result = 'ignore';
                end
                
                test_learn = find(contains(responses_result,'LEARN'));
                
                %     if isempty(test_learn) == 0
                %         test_learn = 0;
                %     end
                
                if test_learn == 1
                    LEARN_indices = [LEARN_indices,version(kk)];
                end
            end
            
            STAY_indices = [];
            
            for kk = 1:length(version)
                test_index = version(kk);
                responses = data(2,test_index);
                responses_result = cell2mat(responses);
                
                if isnan(responses_result) == 1
                    responses_result = 'ignore';
                end
                
                if isnumeric(responses_result) == 1
                    responses_result = 'ignore';
                end
                
                test_learn = find(contains(responses_result,'STAY'));
                
                %     if isempty(test_learn) == 0
                %         test_learn = 0;
                %     end
                
                if test_learn == 1
                    STAY_indices = [STAY_indices,version(kk)];
                end
            end
            
            LEAVE_indices = [];
            
            for kk = 1:length(version)
                test_index = version(kk);
                responses = data(2,test_index);
                responses_result = cell2mat(responses);
                
                if isnan(responses_result) == 1
                    responses_result = 'ignore';
                end
                
                if isnumeric(responses_result) == 1
                    responses_result = 'ignore';
                end
                
                test_learn = find(contains(responses_result,'LEAVE'));
                
                if test_learn == 1
                    LEAVE_indices = [LEAVE_indices,version(kk)];
                end
            end

            BLOCK = cell2mat(data(2,version(end)));
            
            % Convert back
            
            LEARN_turns = LEARN_indices;
            LEARN_RT_indices = LEARN_turns - 2;

            LEAVE_turns = LEAVE_indices;
            LEAVE_RT_indices = LEAVE_turns - 2;
            
            STAY_turns = STAY_indices;
            STAY_RT_indices = STAY_turns - 2;
            
            % Find feedback phase
            
            max2 = max(STAY_turns);
            max3 = max(LEAVE_turns);
            
            if isempty(max2) == 1
                max2 = 0;
            end
            
            if isempty(max3) == 1
                max3 = 0;
            end
            
            if max2 > max3
                Feedback_RT_index = max2 + 7; % STAY
                feedback_response_time = cell2mat(data(2,Feedback_RT_index));
            end
            
            if max3 > max2
                Feedback_RT_index = max3 + 3; % LEAVE
                feedback_response_time = cell2mat(data(2,Feedback_RT_index));
            end
            
            feedback_response_time = cell2mat(data(2,Feedback_RT_index));
            
            % Extract turns left for LEARN
            
            for jj = 1:length(LEARN_turns)
                
                LEARN = data(1,LEARN_turns(jj));
                
                response_time = cell2mat(data(2,LEARN_RT_indices(jj)));
                turn = str2double(extractBetween(LEARN,"q","_v"));
                tokens = str2double(extractBetween(LEARN,"t","_q"));
                alpha = str2double(extractBetween(LEARN,"a","_t"));
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 4 && subj < 212 % exception for messed up timing position
                    response_time = cell2mat(data(2,LEARN_RT_indices(jj)+5));
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 4 % exception for messed up timing position
                    if isnumeric(feedback_response_time) == 1
                        feedback_response_time = feedback_response_time;
                    else
                        feedback_response_time = 'n/a';
                    end
                end
                
                if zz > 4
                    final_value = str2double(extractBetween(LEARN,"i_","_a"));
                else
                    final_value = str2double(extractBetween(LEARN,"e_","_a"));
                end
                
                correct = "n/a";
                stay = "n/a";
                earning = "n/a";
                
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 58  % exception for messed up timing position
                    turn = 2;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 75  % exception for messed up timing position
                    turn = 3;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 87  % exception for messed up timing position
                    turn = 4;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 96  % exception for messed up timing position
                    turn = 5;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 10  % exception for messed up timing position
                    turn = 6;
                end
                
                if isnan(response_time) == 1
                    response_time = 'n/a';
                end
                
                Round_results = [BLOCK, teststr, "dec_learn", turn, tokens, alpha, final_value, "n/a", "n/a", "n/a", response_time];
                Round_participant = [Round_participant; Round_results];
                
            end
            
            % Extract turns left for LEAVE
            
            for jj = 1:length(LEAVE_turns)
                stay = 0;
                LEAVE = data(1,LEAVE_turns(jj));
                
                response_time = cell2mat(data(2,LEAVE_RT_indices(jj)));
                turn = str2double(extractBetween(LEAVE,"q","_v"));
                tokens = str2double(extractBetween(LEAVE,"t","_q"));
                alpha = str2double(extractBetween(LEAVE,"a","_t"));
                question = str2double(extractBetween(LEAVE,"q","_v"));
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 58  % exception for messed up timing position
                    turn = 2;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 75  % exception for messed up timing position
                    turn = 3;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 87  % exception for messed up timing position
                    turn = 4;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 10  % exception for messed up timing position
                    turn = 6;
                end
                
                 if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 58  % exception for messed up timing position
                    turn = 2;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 75  % exception for messed up timing position
                    turn = 3;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 87  % exception for messed up timing position
                    turn = 4;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && question == 5  % exception for messed up timing position
                    turn = 5;
                end
               
              
                if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 10  % exception for messed up timing position
                    turn = 6;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 58  % exception for messed up timing position
                    turn = 2;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 75  % exception for messed up timing position
                    turn = 3;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 87  % exception for messed up timing position
                    turn = 4;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 96  % exception for messed up timing position
                    turn = 5;
                end
                

                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 10  % exception for messed up timing position
                    turn = 6;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && turn == 6  % exception for messed up timing position
                    tokens = 102;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && turn == 6  % exception for messed up timing position
                    tokens = 102;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && turn == 6  % exception for messed up timing position
                    tokens = 102;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && turn == 5  % exception for messed up timing position
                    tokens = 96;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && turn == 5  % exception for messed up timing position
                    tokens = 96;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && turn == 5  % exception for messed up timing position
                    tokens = 96;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && turn == 5  % exception for messed up timing position
                    tokens = 96;
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 4 % exception for messed up timing position
                    response_time = cell2mat(data(2,LEAVE_RT_indices(jj)+5));
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 6 % exception for messed up timing position
                    response_time = cell2mat(data(2,LEAVE_RT_indices(jj)+3));
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 3 % exception for messed up timing position
                    feedback_response_time = cell2mat(data(2,LEAVE_RT_indices(jj)+3));
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 4 % exception for messed up timing position
                    feedback_response_time = 'n/a';
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 5 % exception for messed up timing position
                    feedback_response_time = cell2mat(data(2,Feedback_RT_index));
                end

                if zz > 4
                    final_value = str2double(extractBetween(LEAVE,"i_","_a"));
                else
                    final_value = str2double(extractBetween(LEAVE,"e_","_a"));
                end
                  
                if final_value > 100
                    correct = 0;
                else
                    correct = 1;
                end
                
                if correct == 1 && turn == 1
                    earning = 8.50;
                end
                
                if correct == 1 && turn == 2
                    earning = 8.00;
                end
                
                if correct == 1 && turn == 3
                    earning = 7.50;
                end
                
                if correct == 1 && turn == 4
                    earning = 7.00;
                end
                
                if correct == 1 && turn == 5
                    earning = 6.50;
                end
                
                if correct == 1 && turn == 6
                    earning = 6.00;
                end
                
                if correct == 0
                    earning = 0;
                end
                
                if isnan(response_time) == 1
                    response_time = "n/a";
                end
                
                Round_results = [BLOCK, teststr, "dec_leave", turn, tokens, alpha, final_value, correct, stay, earning, response_time];
                Round_participant = [Round_participant; Round_results];
                
            end
            
            % Extract turns left for STAY
            
            for jj = 1:length(STAY_turns)
                stay = 1;
                STAY = data(1,STAY_turns(jj));
                
                response_time = cell2mat(data(2,STAY_RT_indices(jj)));
                turn = str2double(extractBetween(STAY,"q","_v"));
                tokens = str2double(extractBetween(STAY,"t","_q"));
                alpha = str2double(extractBetween(STAY,"a","_t"));
                question = str2double(extractBetween(STAY,"q","_v"));
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 58  % exception for messed up timing position
                    turn = 2;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 75  % exception for messed up timing position
                    turn = 3;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 87  % exception for messed up timing position
                    turn = 4;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 96  % exception for messed up timing position
                    turn = 5;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && round(tokens) == 10  % exception for messed up timing position
                    turn = 6;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 58  % exception for messed up timing position
                    turn = 2;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 75  % exception for messed up timing position
                    turn = 3;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 87  % exception for messed up timing position
                    turn = 4;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && question == 5  % exception for messed up timing position
                    turn = 5;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && round(tokens) == 10  % exception for messed up timing position
                    turn = 6;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 58  % exception for messed up timing position
                    turn = 2;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 75  % exception for messed up timing position
                    turn = 3;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 87  % exception for messed up timing position
                    turn = 4;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 96  % exception for messed up timing position
                    turn = 5;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && round(tokens) == 10  % exception for messed up timing position
                    turn = 6;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && turn == 6  % exception for messed up timing position
                    tokens = 102;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && turn == 6  % exception for messed up timing position
                    tokens = 102;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && turn == 6  % exception for messed up timing position
                    tokens = 102;
                end
                
                if teststr == "i_116_a1.4" && yy == 3 && turn == 5  % exception for messed up timing position
                    tokens = 96;
                end
                
                if teststr == "i_116_a1.4" && yy == 1 && turn == 5  % exception for messed up timing position
                    tokens = 96;
                end
                
                if teststr == "i_116_a1.4" && yy == 2 && turn == 5  % exception for messed up timing position
                    tokens = 96;
                end
                
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 4 && subj < 216 % exception for messed up timing position
                    response_time = cell2mat(data(2,STAY_RT_indices(jj)+5));
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 4 && subj > 215 % exception for messed up timing position
                    response_time = cell2mat(data(2,STAY_RT_indices(jj)+9));
                end
                
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 6 && subj > 216 % exception for messed up timing position
                    response_time = cell2mat(data(2,STAY_RT_indices(jj)+10));
                end
                
                if teststr == "i_84_a1.4" && yy == 3 && turn == 6 && subj < 215 % exception for messed up timing position
                    response_time = cell2mat(data(2,STAY_RT_indices(jj)+10));
                end
                
                
                if teststr == "e_59_a1.4" && yy == 1 && turn == 4 % exception for messed up timing position
                    feedback_response_time = cell2mat(data(2,STAY_RT_indices(jj)+5));
                end
                
                if zz > 4
                    final_value = str2double(extractBetween(STAY,"i_","_a"));
                else
                    final_value = str2double(extractBetween(STAY,"e_","_a"));
                end
                
                if final_value > 100
                    correct = 1;
                else
                    correct = 0;
                end
                
                if correct == 1 && turn == 1
                    earning = 8.50;
                end
                
                if correct == 1 && turn == 2
                    earning = 8.00;
                end
                
                if correct == 1 && turn == 3
                    earning = 7.50;
                end
                
                if correct == 1 && turn == 4
                    earning = 7.00;
                end
                
                if correct == 1 && turn == 5
                    earning = 6.50;
                end
                
                if correct == 1 && turn == 6
                    earning = 6.00;
                end
                
                if correct == 0
                    earning = 0;
                end
                
                if isnan(response_time) == 1
                    response_time = "n/a";
                end
                
                Round_results = [BLOCK, teststr, "dec_stay", turn, tokens, alpha, final_value, correct, stay, earning, response_time];
                Round_participant = [Round_participant; Round_results];
            end
            
            % exceptions to feedback where feedback is not recorded (i_84)
            % or missing (e_59)
            if yy == 3 && teststr == "i_84_a1.4" && turn == 4
                Bad_Trial = [subj, teststr, yy, turn];
                Record_Bad_Trial = [Record_Bad_Trial; Bad_Trial];
            elseif yy == 3 && teststr == "i_84_a1.4" && turn == 3 && subj < 70 
                Bad_Trial = [subj, teststr, yy, turn];
                Record_Bad_Trial = [Record_Bad_Trial; Bad_Trial]; 
            elseif yy == 3 && teststr == "i_84_a1.4" && turn == 3 && subj > 70 && stay == 1
                Bad_Trial = [subj, teststr, yy, turn];
                Record_Bad_Trial = [Record_Bad_Trial; Bad_Trial];
            elseif yy == 2 && teststr == "e_59_a1.4" && turn == 4 && stay == 1
                Bad_Trial = [subj, teststr, yy, turn];
                Record_Bad_Trial = [Record_Bad_Trial; Bad_Trial];
            elseif yy == 3 && teststr == "e_59_a1.4" && turn == 4 && stay == 1
                Bad_Trial = [subj, teststr, yy, turn];
                Record_Bad_Trial = [Record_Bad_Trial; Bad_Trial];
            else
                if isnan(feedback_response_time) == 1
                    feedback_response_time = "n/a";
                end
                
                add_feedback = [BLOCK, teststr, "feedback", turn, "n/a", alpha, final_value, "n/a", "n/a", "n/a", feedback_response_time];
                Round_participant = [Round_participant; add_feedback];
            end
        end
        
        Full_Participant = [Full_Participant; Round_participant];
    end
    
    %% Order participant by block
    
    blocks_first = char(Full_Participant(:,1));
    blocks = str2num(blocks_first);
    
    [C,~] = size(blocks);
    order = 1:C;
    ordered = [blocks,order'];
    E = sortrows(ordered);
    
    Final_Participant = [];

    for oo = 1:C
        pick_row = E(oo,2);
        saverow = Full_Participant(pick_row,:);
        Final_Participant = [Final_Participant; saverow];
    end

%     %% Add onsets column
%     
%     responses_first = str2mat(Final_Participant(:,11));
%     responses = str2num(responses_first);
%     onsets = cumsum(responses);
%     
%     Use_Participant = [Final_Participant,onsets]; 

     %% Output in TSV format
     
     vals = str2double(Final_Participant);
     use_vals = array2table(vals);
     nanvals = isnan(vals);
     test_participant = array2table(Final_Participant);
     
     fname = sprintf('sub-%03d_task-staygo2_beh.tsv',subj); % making compatible with bids output
     output = fullfile(usedir,'bids',['sub-' num2str(partnum)],'beh');
     if ~exist(output)
         mkdir(output)
     end
     
     myfile = fullfile(output,fname);
     fid = fopen(myfile,'w');
     fprintf(fid,'block\ttrial_type\tphase\tturn\ttokens\talpha\tfinal_value\tcorrect\tstay\tearnings\tresponse_time\n');

     for pp = 1:C % for each row
         row = [];
         saverow = nanvals(pp,:);
         for zz = 1:length(saverow)
             testval = saverow(zz);
             if testval == 0
                 saveval = use_vals(pp,zz);
             end
             if testval == 1
                 saveval = test_participant(pp,zz);
             end
             row = [row,saveval];
             
             % Might need to do the fprintf thing here to output the tsv.
         end
         
%          if round(L_Option(t)) > 0;
%              fprintf(fid,'%f\t%f\t%s\t%f\t%d\t%s\t%d\t%d\n',decision_onset(t),RT(t),[trial_type '_option_presented'],RT(t),Endowment(t),'n/a',Endowment(t) - L_Option(t), L_Option(t)/Endowment(t)- UGR_mean); % accepted offer
%          else
%              fprintf(fid,'%f\t%f\t%s\t%f\t%d\t%s\t%d\t%d\n',decision_onset(t),RT(t),[trial_type '_option_presented'],RT(t),Endowment(t),'n/a',0, R_Option(t)/Endowment(t)- UGR_mean); % rejected offer
%          end
%          
         row.Properties.VariableNames = {'block','trial_type','phase','turn','tokens','alpha','final_value','correct','stay','earnings','response_time'};
         
         if row.phase ==  "feedback"
             row = table2array(row);
             fprintf(fid,'%f\t%s\t%s\t%s\t%s\t%f\t%f\t%s\t%s\t%s\t%s\n',row); % accepted offer
         else  
             row = table2array(row);
             fprintf(fid,'%f\t%s\t%s\t%f\t%f\t%f\t%f\t%s\t%s\t%s\t%s\n',row);
         end  
     end
     fclose(fid);  
     
     %% Make list of bad trials
     
     [G,~] = size(Record_Bad_Trial);
    
     if G > 0
         Record_Bad_Trial = array2table(Record_Bad_Trial);
         Record_Bad_Trial.Properties.VariableNames = {'subject','trial_type','version','turn'};
         Record_Bad_Trial
         All_Bad_Trials = [All_Bad_Trials;Record_Bad_Trial];
     end

     
     %% Catch failed output
     
%     catch ME
%         disp(["subj_" subj "debug"])
%     end
 end

[K,~] = size(All_Bad_Trials);

if K > 0
    filename = [pwd '\Missing_Feedback_Trials.csv'];
    writetable(All_Bad_Trials, filename); % Save file in table form
end


