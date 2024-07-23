% Initialization

clear all;
close all;
clc;

% Daniel Sazhin
% 03/15/24
% Neuroeconomics Lab
% Temple University.
% StayGo 2 Project

% This code takes in the main spreadsheet and outputs into sourcedata.

% Outputs: Participant folder and file.

%%

[pathstr,~,~] = fileparts(pwd);
usedir = pathstr;

rawdatadir = fullfile(usedir,'bids','sourcedata','Qualtrics_sourcedata.xlsx');
[n,t,rawdata] = xlsread(rawdatadir);
headers = t(1,:); % Pulls out the headers

data = rawdata(3:end,:); % Participant data
[N,~]=size(data); % Total Subjects

[pathstr,name,ext] = fileparts(pwd);

usedir = pathstr;

%[pathstr2,name,ext] = fileparts(usedir)

maindir = fullfile(usedir,'bids');
%%

sub_list = [];

for ii = 1:N
    partnum = num2str(ii,'%03.f');
    outputdir_name = fullfile(maindir,'sourcedata',(['sub-' partnum]));

    if isfolder(outputdir_name) == 1
        rmdir(outputdir_name, 's')
    end

    mkdir(outputdir_name);

    raw_participant = data(ii,:);
    participant = [headers;raw_participant];

    tempname = fullfile(outputdir_name,(['sub-' partnum]));
    filename = [tempname '.xlsx'];
    writecell(participant,filename);% Save file in table form

    sub_list = [sub_list;partnum];
end

filename = fullfile(pwd,'Subjects_Before_Exclusions.txt');

    if isfile(filename) == 1
        delete(filename)
    end

writematrix(sub_list, filename); % Save file in table form
