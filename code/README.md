# Relevant Scripts

All custom code goes into this directory. All scripts are written such that they can be executed from the root of the dataset, and are only using relative paths for portability.

The code inputs the sourcedata from [Qualtrics_sourcedata.xlsx](../bids/sourcedata/Qualtrics_sourcedata.xlsx).

1. The [extract_sourcedata.m](code/extract_sourcedata.m) Script that extracts raw data and converts it into individual subjects. 
2. The [Staygo2_TSV_Converter.m](code/Staygo2_TSV_Converter.m) Extracts task data from each subject and converts it into BIDS format. 
3. The [Stago2_TSV_Comprehension.m](code/Stago2_TSV_Comprehension.m) Extracts comprehension checks (yes/no decision and value predicted) 
4. The [StayGo2_extract_phenotypes.m](code/StayGo2_extract_phenotypes.m) Specifies survey data in our sample for each participant. 
5. The [StayGo2_Surveys_Scored.m](code/StayGo2_Surveys_Scored.m) Scores the participants survey responses into outputs for analysis.
6. The [reliability.R](code/reliability_coefficient/reliability.R) Finds the reliability coefficients for the survey data in the phenotype directory.

## Conversion of Sourcedata to BIDS Format:

The data was processed using the following steps.

1. Downloaded from Qualtrics and deidentified. We excluded the following columns to minimize the risk of identification: IP address, response ID, Location (longitude), Location (latitude), childhood city, and childhood zipcode.
2. Extracted sourcedata using [extract_sourcedata.m](code/extract_sourcedata.m). This step creates an identifier for each participant and places their data within a folder in sourcedata.
3. Converted behavioral data from sourcedata into bids format using [StayGo2_TSV_Converter.m](code/StayGo2_TSV_Converter.m). This code outputs a *-beh.tsv file for each participant subfolder in the bids directory. 
4. Converted comprehension check data from sourcedata into bids format using [StayGo2_TSV_Comprehension.m](code/StayGo2_TSV_Comprehension.m). This code outputs a *-comprehension_checks.tsv and *-comprehension_decision.tsv file for each participant subfolder in the bids directory. 
5. Generated phenotypes using [StayGo2_extract_phenotypes.m](code/StayGo2_extract_phenotypes.m) in bids format in the bids/phenotypes directory. Additionally, this script generates a participants.tsv file in the bids directory.

## Questionnaire files:

1. We included a reference file for the stimuli that participants experienced. See [survey_questions.docx](code/survey_questions.docx) to access questionnaire items.
2. Additionally, we included the survey implemented in Qualtrics. If you wish to access or reproduce the survey, upload [StayGo2.qsf](code/StayGo2.qsf) to Qualtrics to see how the survey was coded, or to try it out yourself.

