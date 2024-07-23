%% Initialization

clear all;
close all;
clc;

[pathstr,name,ext] = fileparts(pwd);
usedir = pathstr;

rawdatadir = fullfile(usedir,'bids','sourcedata','Qualtrics_sourcedata');
[n,t,data] = xlsread(rawdatadir);

%data = [headers; rawdatadir]; % Add the headers back so we know what we are working with.

% We now have the data that has been sorted through the exclusion criteria.

%[m,~] = size(data);
%TotalSubjects = m-1; % This sets the total subjects for further analysis.

% I left TotalSubjects in for each scale just in case subjects were
% arbitarily excluded for certain items.

%% 7up7down

% Exclude all data except 7up7down scores.

start = find(strcmp('7up7down_1',data(1,:))); % Find the 7up7down 1 column,
finish = find(strcmp('7up7down_14',data(1,:))); % Find the 7up7down 12 column.
N = 14; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); % Index all of the SevenUp columns.
SevenUpSevenDown_data = data(3:end,IndexedColumns); % Save them

SevenUpSevenDown_data = strrep(SevenUpSevenDown_data,'Never or hardly ever','1');
SevenUpSevenDown_data = strrep(SevenUpSevenDown_data,'Sometimes','2');
SevenUpSevenDown_data = strrep(SevenUpSevenDown_data,'Often','3');
SevenUpSevenDown_data = strrep(SevenUpSevenDown_data,'Very often or almost constantly','4');


[n,m] = size(SevenUpSevenDown_data);
SevenUpSevenDown_data_process = [];

for ii = 1:(n) % for each participant
    participant = [];
    for jj = 1:m % for each question
        response = SevenUpSevenDown_data(ii,jj);
        response = str2double(response);
        participant = [participant, response];
    end
    SevenUpSevenDown_data_process = [SevenUpSevenDown_data_process; participant]; % Final scores
end

SevenUp = [];
[n,m] = size(SevenUpSevenDown_data_process);
for ii = 1:n
    row = SevenUpSevenDown_data_process(ii,:);
    participant = row([1 3 4 6 7 8 13]);
    saveme = sum(participant);
    SevenUp = [SevenUp; saveme];
end

SevenDown = [];
[n,m] = size(SevenUpSevenDown_data_process);
for ii = 1:n
    row = SevenUpSevenDown_data_process(ii,:);
    participant = row([2 5 9 10 11 12 14]);
    saveme = sum(participant);
    SevenDown = [SevenDown; saveme];
end

%% PROMIS

start = find(strcmp('PROMIS_1',data(1,:))); 
finish = find(strcmp('PROMIS_8',data(1,:)));
N = 8; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
PROMIS_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(PROMIS_Data);

PROMIS = [];

for kk = 1:N-2
    Subject = PROMIS_Data(kk+2,:);
    
    StronglyDisagree = find(strcmp('Never',Subject(:,:)));
    Disagree = find(strcmp('Rarely',Subject(:,:)));
    Undecided = find(strcmp('Sometimes',Subject(:,:)));
    Agree = find(strcmp('Often',Subject(:,:)));
    StronglyAgree = find(strcmp('Always',Subject(:,:)));
    
    StronglyDisagree = length(StronglyDisagree) *1;
    Disagree = length(Disagree) *2;
    Undecided = length(Undecided) *3;
    Agree = length(Agree) *4;
    StronglyAgree = length(StronglyAgree) *5;
    
    PROMIS = [PROMIS; StronglyDisagree+Disagree+Undecided+Agree+StronglyAgree];
    
end

%% Loneliness

start = find(strcmp('Loneliness_1',data(1,:))); 
finish = find(strcmp('Loneliness_3',data(1,:)));
N = 3; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Loneliness_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(Loneliness_Data);

Loneliness = [];

for kk = 1:N-2
    Subject = Loneliness_Data(kk+2,:);
    
    HardlyEver = find(strcmp('Hardly Ever',Subject(:,:)));
    Sometimes = find(strcmp('Some of the time',Subject(:,:)));
    Often = find(strcmp('Sometimes',Subject(:,:)));
    
    HardlyEver = length(HardlyEver) *1;
    Sometimes = length(Sometimes) *2;
    Often = length(Often) *3;
   
    Loneliness = [Loneliness; HardlyEver+Sometimes+Often];
end

%% Ethical Risk

start = find(strcmp('ethRT_1',data(1,:))); 
finish = find(strcmp('ethRT_6',data(1,:)));
N = 6; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Ethical_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(Ethical_Data);

Ethical = [];

for kk = 1:N-2
    Subject = Ethical_Data(kk+2,:);
    
    ExtremelyUnlikely = find(strcmp('Extremely Unlikely',Subject(:,:)));
    ModeratelyUnlikely = find(strcmp('Moderately Unlikely',Subject(:,:)));
    SomewhatUnlikely = find(strcmp('Somewhat Unlikely',Subject(:,:)));
    NotSure = find(strcmp('Not Sure',Subject(:,:)));
    SomewhatLikely = find(strcmp('Somewhat Likely',Subject(:,:)));
    ModeratelyLikely = find(strcmp('Moderately Likely',Subject(:,:)));
    ExtremelyLikely = find(strcmp('Extremely Likely',Subject(:,:)));
    
    ExtremelyUnlikely = length(ExtremelyUnlikely) *1;
    ModeratelyUnlikely = length(ModeratelyUnlikely) *2;
    SomewhatUnlikely = length(SomewhatUnlikely) *3;
    NotSure = length(NotSure) *4;
    SomewhatLikely = length(SomewhatLikely) *5;
    ModeratelyLikely = length(ModeratelyLikely) *6;
    ExtremelyLikely = length(ExtremelyLikely) *7;
   
    Ethical = [Ethical; ExtremelyUnlikely+ModeratelyUnlikely+SomewhatUnlikely+NotSure+SomewhatLikely+ModeratelyLikely+ExtremelyLikely];
end

%% Financial Risk

start = find(strcmp('finRT_1',data(1,:))); 
finish = find(strcmp('finRT_6',data(1,:)));
N = 6; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Financial_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(Financial_Data);

Financial = [];

for kk = 1:N-2
    Subject = Financial_Data(kk+2,:);
    
    ExtremelyUnlikely = find(strcmp('Extremely Unlikely',Subject(:,:)));
    ModeratelyUnlikely = find(strcmp('Moderately Unlikely',Subject(:,:)));
    SomewhatUnlikely = find(strcmp('Somewhat Unlikely',Subject(:,:)));
    NotSure = find(strcmp('Not Sure',Subject(:,:)));
    SomewhatLikely = find(strcmp('Somewhat Likely',Subject(:,:)));
    ModeratelyLikely = find(strcmp('Moderately Likely',Subject(:,:)));
    ExtremelyLikely = find(strcmp('Extremely Likely',Subject(:,:)));
    
    ExtremelyUnlikely = length(ExtremelyUnlikely) *1;
    ModeratelyUnlikely = length(ModeratelyUnlikely) *2;
    SomewhatUnlikely = length(SomewhatUnlikely) *3;
    NotSure = length(NotSure) *4;
    SomewhatLikely = length(SomewhatLikely) *5;
    ModeratelyLikely = length(ModeratelyLikely) *6;
    ExtremelyLikely = length(ExtremelyLikely) *7;
   
    Financial = [Financial; ExtremelyUnlikely+ModeratelyUnlikely+SomewhatUnlikely+NotSure+SomewhatLikely+ModeratelyLikely+ExtremelyLikely];
end

%% Gambling and Investing Risk

start = find(strcmp('finRT_1',data(1,:))); 
finish = find(strcmp('finRT_6',data(1,:)));
N = 6; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Financial_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(Financial_Data);

Gambling = [];
Investing = [];

for kk = 1:N-2
    Subject = Financial_Data(kk+2,:);
    
    G1=Subject(1);
    G2=Subject(3);
    G3=Subject(5);
    
    I1=Subject(2);
    I2=Subject(4);
    I3=Subject(6);
    
    Subject_Gambling = [G1,G2,G3];
    Subject_Investing = [I1,I2,I3];
    
    ExtremelyUnlikely = find(strcmp('Extremely Unlikely',Subject_Gambling(:,:)));
    ModeratelyUnlikely = find(strcmp('Moderately Unlikely',Subject_Gambling(:,:)));
    SomewhatUnlikely = find(strcmp('Somewhat Unlikely',Subject_Gambling(:,:)));
    NotSure = find(strcmp('Not Sure',Subject_Gambling(:,:)));
    SomewhatLikely = find(strcmp('Somewhat Likely',Subject_Gambling(:,:)));
    ModeratelyLikely = find(strcmp('Moderately Likely',Subject_Gambling(:,:)));
    ExtremelyLikely = find(strcmp('Extremely Likely',Subject_Gambling(:,:)));
    
    ExtremelyUnlikely = length(ExtremelyUnlikely) *1;
    ModeratelyUnlikely = length(ModeratelyUnlikely) *2;
    SomewhatUnlikely = length(SomewhatUnlikely) *3;
    NotSure = length(NotSure) *4;
    SomewhatLikely = length(SomewhatLikely) *5;
    ModeratelyLikely = length(ModeratelyLikely) *6;
    ExtremelyLikely = length(ExtremelyLikely) *7;
   
    Gambling = [Gambling; ExtremelyUnlikely+ModeratelyUnlikely+SomewhatUnlikely+NotSure+SomewhatLikely+ModeratelyLikely+ExtremelyLikely];

    ExtremelyUnlikely = find(strcmp('Extremely Unlikely',Subject_Investing(:,:)));
    ModeratelyUnlikely = find(strcmp('Moderately Unlikely',Subject_Investing(:,:)));
    SomewhatUnlikely = find(strcmp('Somewhat Unlikely',Subject_Investing(:,:)));
    NotSure = find(strcmp('Not Sure',Subject_Investing(:,:)));
    SomewhatLikely = find(strcmp('Somewhat Likely',Subject_Investing(:,:)));
    ModeratelyLikely = find(strcmp('Moderately Likely',Subject_Investing(:,:)));
    ExtremelyLikely = find(strcmp('Extremely Likely',Subject_Investing(:,:)));
    
    ExtremelyUnlikely = length(ExtremelyUnlikely) *1;
    ModeratelyUnlikely = length(ModeratelyUnlikely) *2;
    SomewhatUnlikely = length(SomewhatUnlikely) *3;
    NotSure = length(NotSure) *4;
    SomewhatLikely = length(SomewhatLikely) *5;
    ModeratelyLikely = length(ModeratelyLikely) *6;
    ExtremelyLikely = length(ExtremelyLikely) *7;
    
    Investing = [Investing; ExtremelyUnlikely+ModeratelyUnlikely+SomewhatUnlikely+NotSure+SomewhatLikely+ModeratelyLikely+ExtremelyLikely];
end

%% Health Risk

start = find(strcmp('heaRT_1',data(1,:))); 
finish = find(strcmp('heaRT_6',data(1,:)));
N = 6; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Health_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(Health_Data);

Health = [];

for kk = 1:N-2
    Subject = Health_Data(kk+2,:);
    
    ExtremelyUnlikely = find(strcmp('Extremely Unlikely',Subject(:,:)));
    ModeratelyUnlikely = find(strcmp('Moderately Unlikely',Subject(:,:)));
    SomewhatUnlikely = find(strcmp('Somewhat Unlikely',Subject(:,:)));
    NotSure = find(strcmp('Not Sure',Subject(:,:)));
    SomewhatLikely = find(strcmp('Somewhat Likely',Subject(:,:)));
    ModeratelyLikely = find(strcmp('Moderately Likely',Subject(:,:)));
    ExtremelyLikely = find(strcmp('Extremely Likely',Subject(:,:)));
    
    ExtremelyUnlikely = length(ExtremelyUnlikely) *1;
    ModeratelyUnlikely = length(ModeratelyUnlikely) *2;
    SomewhatUnlikely = length(SomewhatUnlikely) *3;
    NotSure = length(NotSure) *4;
    SomewhatLikely = length(SomewhatLikely) *5;
    ModeratelyLikely = length(ModeratelyLikely) *6;
    ExtremelyLikely = length(ExtremelyLikely) *7;
   
    Health = [Health; ExtremelyUnlikely+ModeratelyUnlikely+SomewhatUnlikely+NotSure+SomewhatLikely+ModeratelyLikely+ExtremelyLikely];
end


%% Recreational Risk

start = find(strcmp('recRT_1',data(1,:))); 
finish = find(strcmp('recRT_6',data(1,:)));
N = 6; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Recreational_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(Recreational_Data);

Recreational = [];

for kk = 1:N-2
    Subject = Recreational_Data(kk+2,:);
    
    ExtremelyUnlikely = find(strcmp('Extremely Unlikely',Subject(:,:)));
    ModeratelyUnlikely = find(strcmp('Moderately Unlikely',Subject(:,:)));
    SomewhatUnlikely = find(strcmp('Somewhat Unlikely',Subject(:,:)));
    NotSure = find(strcmp('Not Sure',Subject(:,:)));
    SomewhatLikely = find(strcmp('Somewhat Likely',Subject(:,:)));
    ModeratelyLikely = find(strcmp('Moderately Likely',Subject(:,:)));
    ExtremelyLikely = find(strcmp('Extremely Likely',Subject(:,:)));
    
    ExtremelyUnlikely = length(ExtremelyUnlikely) *1;
    ModeratelyUnlikely = length(ModeratelyUnlikely) *2;
    SomewhatUnlikely = length(SomewhatUnlikely) *3;
    NotSure = length(NotSure) *4;
    SomewhatLikely = length(SomewhatLikely) *5;
    ModeratelyLikely = length(ModeratelyLikely) *6;
    ExtremelyLikely = length(ExtremelyLikely) *7;
   
    Recreational = [Recreational; ExtremelyUnlikely+ModeratelyUnlikely+SomewhatUnlikely+NotSure+SomewhatLikely+ModeratelyLikely+ExtremelyLikely];
end

%% Health Risk

start = find(strcmp('socRT_1',data(1,:))); 
finish = find(strcmp('socRT_6',data(1,:)));
N = 6; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Social_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,~]= size(Social_Data);

Social = [];

for kk = 1:N-2
    Subject = Social_Data(kk+2,:);
    
    ExtremelyUnlikely = find(strcmp('Extremely Unlikely',Subject(:,:)));
    ModeratelyUnlikely = find(strcmp('Moderately Unlikely',Subject(:,:)));
    SomewhatUnlikely = find(strcmp('Somewhat Unlikely',Subject(:,:)));
    NotSure = find(strcmp('Not Sure',Subject(:,:)));
    SomewhatLikely = find(strcmp('Somewhat Likely',Subject(:,:)));
    ModeratelyLikely = find(strcmp('Moderately Likely',Subject(:,:)));
    ExtremelyLikely = find(strcmp('Extremely Likely',Subject(:,:)));
    
    ExtremelyUnlikely = length(ExtremelyUnlikely) *1;
    ModeratelyUnlikely = length(ModeratelyUnlikely) *2;
    SomewhatUnlikely = length(SomewhatUnlikely) *3;
    NotSure = length(NotSure) *4;
    SomewhatLikely = length(SomewhatLikely) *5;
    ModeratelyLikely = length(ModeratelyLikely) *6;
    ExtremelyLikely = length(ExtremelyLikely) *7;
   
    Social = [Social; ExtremelyUnlikely+ModeratelyUnlikely+SomewhatUnlikely+NotSure+SomewhatLikely+ModeratelyLikely+ExtremelyLikely];
end

%% DOSPERT TOTAL

DOSPERT = [Ethical+Social+Recreational+Financial+Health];

%% Ecog

start = find(strcmp('Ecog_2',data(1,:))); 
finish = find(strcmp('Ecog_14',data(1,:)));
N = 13; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
Ecog_Data = data(:,IndexedColumns); % Save them

% Convert text into values

[N,M]= size(Ecog_Data);

Ecog = [];

for kk = 1:N-2
    Subject = Ecog_Data(kk+2,:);
    
    if find(strcmp('A little worse all the time',Subject(:,10))) == 1
        
        concat = Subject(1:9);
        catcon = Subject(11:13);
        
        Subject = [concat,catcon];

        Better = find(strcmp('Better or no change',Subject(:,:)));
        Sometimes = find(strcmp('A little worse sometimes',Subject(:,:)));
        AllTime = find(strcmp('A little worse all the time',Subject(:,:)));
        MuchWorse = find(strcmp('Much worse',Subject(:,:)));
        DontKnow = find(strcmp("Don't know",Subject(:,:)));
        
        Better = length(Better) *1;
        Sometimes = length(Sometimes) *2;
        AllTime = length(AllTime) *3;
        MuchWorse = length(MuchWorse) *4;
        DontKnow = length(DontKnow) *0;
        
        Ecog = [Ecog; ((Better+Sometimes+AllTime+MuchWorse+DontKnow)/(13-length(DontKnow)))];
        
    else
        
        ii
        disp('Bad subject Ecog')    
    end
end

%% ABIS

start = find(strcmp('ABIS_1',data(1,:))); 
finish = find(strcmp('ABIS_13',data(1,:)));
N = 13; % Number of questions
IndexedColumns = round(linspace(start,finish, N)); 
ABIS_Data = data(3:end,IndexedColumns); % Save them
% Convert text into values

[N,~]= size(ABIS_Data);

Attention = [];
Nonplanning = [];
Motor = [];

for kk = 1:N % For all subjects
    Subject = ABIS_Data(kk,:);
    
    Q1_Never = find(strcmp('Rarely/Never',Subject(1)));
    Q1_Occasionally = find(strcmp('Occasionally',Subject(1)));
    Q1_Often = find(strcmp('Often',Subject(1)));
    Q1_Always = find(strcmp('Always',Subject(1)));
    
    Q1_Never = length(Q1_Never) *4;
    Q1_Occasionally = length(Q1_Occasionally) *3;
    Q1_Often = length(Q1_Often) *2;
    Q1_Always = length(Q1_Always) *1;
    
    Q1 = (Q1_Never+Q1_Occasionally+Q1_Often+Q1_Always);
    
    Q2_Never = find(strcmp('Rarely/Never',Subject(2)));
    Q2_Occasionally = find(strcmp('Occasionally',Subject(2)));
    Q2_Often = find(strcmp('Often',Subject(2)));
    Q2_Always = find(strcmp('Always',Subject(2)));
    
    Q2_Never = length(Q2_Never) *4;
    Q2_Occasionally = length(Q2_Occasionally) *3;
    Q2_Often = length(Q2_Often) *2;
    Q2_Always = length(Q2_Always) *1;
    
    Q2 = (Q2_Never+Q2_Occasionally+Q2_Often+Q2_Always);
    
    Q3_Never = find(strcmp('Rarely/Never',Subject(3)));
    Q3_Occasionally = find(strcmp('Occasionally',Subject(3)));
    Q3_Often = find(strcmp('Often',Subject(3)));
    Q3_Always = find(strcmp('Always',Subject(3)));
    
    Q3_Never = length(Q3_Never) *1;
    Q3_Occasionally = length(Q3_Occasionally) *2;
    Q3_Often = length(Q3_Often) *3;
    Q3_Always = length(Q3_Always) *4;
    
    Q3 = (Q3_Never+Q3_Occasionally+Q3_Often+Q3_Always);
    
    Q4_Never = find(strcmp('Rarely/Never',Subject(4)));
    Q4_Occasionally = find(strcmp('Occasionally',Subject(4)));
    Q4_Often = find(strcmp('Often',Subject(4)));
    Q4_Always = find(strcmp('Always',Subject(4)));
    
    Q4_Never = length(Q4_Never) *4;
    Q4_Occasionally = length(Q4_Occasionally) *3;
    Q4_Often = length(Q4_Often) *2;
    Q4_Always = length(Q4_Always) *1;
    
    Q4 = (Q4_Never+Q4_Occasionally+Q4_Often+Q4_Always);
    
    Q5_Never = find(strcmp('Rarely/Never',Subject(5)));
    Q5_Occasionally = find(strcmp('Occasionally',Subject(5)));
    Q5_Often = find(strcmp('Often',Subject(5)));
    Q5_Always = find(strcmp('Always',Subject(5)));
    
    Q5_Never = length(Q5_Never) *4;
    Q5_Occasionally = length(Q5_Occasionally) *3;
    Q5_Often = length(Q5_Often) *2;
    Q5_Always = length(Q5_Always) *1;
    
    Q5 = (Q5_Never+Q5_Occasionally+Q5_Often+Q5_Always);
    
    Q6_Never = find(strcmp('Rarely/Never',Subject(6)));
    Q6_Occasionally = find(strcmp('Occasionally',Subject(6)));
    Q6_Often = find(strcmp('Often',Subject(6)));
    Q6_Always = find(strcmp('Always',Subject(6)));
    
    Q6_Never = length(Q6_Never) *1;
    Q6_Occasionally = length(Q6_Occasionally) *2;
    Q6_Often = length(Q6_Often) *3;
    Q6_Always = length(Q6_Always) *4;
    
    Q6 = (Q6_Never+Q6_Occasionally+Q6_Often+Q6_Always);
    
    Q7_Never = find(strcmp('Rarely/Never',Subject(7)));
    Q7_Occasionally = find(strcmp('Occasionally',Subject(7)));
    Q7_Often = find(strcmp('Often',Subject(7)));
    Q7_Always = find(strcmp('Always',Subject(7)));
    
    Q7_Never = length(Q7_Never) *4;
    Q7_Occasionally = length(Q7_Occasionally) *3;
    Q7_Often = length(Q7_Often) *2;
    Q7_Always = length(Q7_Always) *1;
    
    Q7 = (Q7_Never+Q7_Occasionally+Q7_Often+Q7_Always);
    
    Q8_Never = find(strcmp('Rarely/Never',Subject(8)));
    Q8_Occasionally = find(strcmp('Occasionally',Subject(8)));
    Q8_Often = find(strcmp('Often',Subject(8)));
    Q8_Always = find(strcmp('Always',Subject(8)));
    
    Q8_Never = length(Q8_Never) *1;
    Q8_Occasionally = length(Q8_Occasionally) *2;
    Q8_Often = length(Q8_Often) *3;
    Q8_Always = length(Q8_Always) *4;
    
    Q8 = (Q8_Never+Q8_Occasionally+Q8_Often+Q8_Always);
    
    Q9_Never = find(strcmp('Rarely/Never',Subject(9)));
    Q9_Occasionally = find(strcmp('Occasionally',Subject(9)));
    Q9_Often = find(strcmp('Often',Subject(9)));
    Q9_Always = find(strcmp('Always',Subject(9)));
    
    Q9_Never = length(Q9_Never) *1;
    Q9_Occasionally = length(Q9_Occasionally) *2;
    Q9_Often = length(Q9_Often) *3;
    Q9_Always = length(Q9_Always) *4;
    
    Q9 = (Q9_Never+Q9_Occasionally+Q9_Often+Q9_Always);
    
    Q10_Never = find(strcmp('Rarely/Never',Subject(10)));
    Q10_Occasionally = find(strcmp('Occasionally',Subject(10)));
    Q10_Often = find(strcmp('Often',Subject(10)));
    Q10_Always = find(strcmp('Always',Subject(10)));
    
    Q10_Never = length(Q10_Never) *1;
    Q10_Occasionally = length(Q10_Occasionally) *2;
    Q10_Often = length(Q10_Often) *3;
    Q10_Always = length(Q10_Always) *4;
    
    Q10 = (Q10_Never+Q10_Occasionally+Q10_Often+Q10_Always);
    
    Q11_Never = find(strcmp('Never',Subject(11)));
    Q11_Occasionally = find(strcmp('Occasionally',Subject(11)));
    Q11_Often = find(strcmp('Often',Subject(11)));
    Q11_Always = find(strcmp('Always',Subject(11)));
    
    Q11_Never = length(Q11_Never) *4;
    Q11_Occasionally = length(Q11_Occasionally) *3;
    Q11_Often = length(Q11_Often) *2;
    Q11_Always = length(Q11_Always) *1;
    
    Q11 = (Q11_Never+Q11_Occasionally+Q11_Often+Q11_Always);
    
    Q12_Never = find(strcmp('Never',Subject(12)));
    Q12_Occasionally = find(strcmp('Occasionally',Subject(12)));
    Q12_Often = find(strcmp('Often',Subject(12)));
    Q12_Always = find(strcmp('Always',Subject(12)));
    
    Q12_Never = length(Q12_Never) *4;
    Q12_Occasionally = length(Q12_Occasionally) *3;
    Q12_Often = length(Q12_Often) *2;
    Q12_Always = length(Q12_Always) *1;
    
    Q12 = (Q12_Never+Q12_Occasionally+Q12_Often+Q12_Always);
    
    Q13_Never = find(strcmp('Never',Subject(13)));
    Q13_Occasionally = find(strcmp('Occasionally',Subject(13)));
    Q13_Often = find(strcmp('Often',Subject(13)));
    Q13_Always = find(strcmp('Always',Subject(13)));
    
    Q13_Never = length(Q13_Never) *4;
    Q13_Occasionally = length(Q13_Occasionally) *3;
    Q13_Often = length(Q13_Often) *2;
    Q13_Always = length(Q13_Always) *1;
    
    Q13 = (Q13_Never+Q13_Occasionally+Q13_Often+Q13_Always);

    Attention = [Attention; (Q1+Q4+Q7+Q9+Q12)/5];
    Motor = [Motor;(Q3+Q6+Q8+Q10)/4];
    Nonplanning = [Nonplanning; (Q2+Q5+Q11+Q13)/4];
    
end

%% Demographics

% Find the columns you will need.

start = find(strcmp('DQ',data(1,:))); % Take slice of data.
finish = find(strcmp('Ethnicity',data(1,:)));
N = 6; % Number of questions
IndexedColumns = round(linspace(start(1),finish, N));
demo_data = data(:,IndexedColumns);
Age = str2double(demo_data(3:end,3));
mean_age= mean(Age);
std_age= std(Age);
range_age=range(Age);

Ethnicity = demo_data(3:end,5);
Gender = demo_data(3:end,4);
[N,~] = size(find(strcmp('Female',Gender)));
[M,~] = size(find(strcmp('Hispanic or Latino',Ethnicity)));
[O,~] = size(Ethnicity);
prop_hispanic = M/O;

%% Save

All_Surveys = [Age, Ecog, PROMIS, SevenUp, SevenDown, Loneliness,DOSPERT,Financial,Gambling,Investing,Social,Recreational,Health,Attention,Nonplanning,Motor];

Surveys = array2table(All_Surveys(1:end,:),'VariableNames', {'Age' 'Ecog' 'PROMIS' 'SevenUp' 'SevenDown' 'Loneliness','DOSPERT','Financial','Gambling','Investing','Social','Recreational','Health','Attention', 'Nonplanning','Motor'});

filename = [pwd '\Surveys.xls'];
writetable(Surveys, filename) % Save file in table form
