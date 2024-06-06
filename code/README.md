All custom code goes into this directory. All scripts are written such that they can be executed from the root of the dataset, and are only using relative paths for portability.

extract_sourcedata.m: This code extracts each participant from the main spreadsheet "StayGo2_data_final.xlsx" in bids/sourcedata/rawdata. Each participant is then generated a subject number and extracted into a separate .xls file within rawdata.

StayGo2_TSV_Converter.m: To generate tsv files in the BIDS directory for the Gold Mine task, use StayGo2_TSV_Converter.m. This code extracts the information needed to generate three column files. Open Matlab and hit run to make the TSV files.

StayGo2_TSV_Comprehension.m: To extract the four comprehension checks for the Gold Mine task, use StayGo2_TSV_Comprehension.m. Open MATLAB and hit run. This code outputs two files in each bids/subject directory. sub-###_task-staygo2_run-1_comprehension_decisions.tsv specifies the decisions made whether the participant would keep the mine (Yes/No). sub-###_task-staygo2_run-1_comprehension_checks.tsv specifies the values the participant selected for their prediction on the 7th and 12th turn. Note that the first row is the values selected by the participant, whereas the second row is the actual value in the trend.

StayGo2_extract_phenotypes.m: To extract phenotype data, open this file in MATLAB and hit Run. PROMIS, EcoG, 7Up7Down, ABIS, DOSPERT, SES, Loneliness are output as separate phenotypes. SES and demographic information are provided in the "Participants.tsv" file.

