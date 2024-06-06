# Relevant Scripts

All custom code goes into this directory. All scripts are written such that they can be executed from the root of the dataset, and are only using relative paths for portability.

The code inputs the sourcedata from [Qualtrics_sourcedata.xlsx](../bids/sourcedata/Qualtrics_sourcedata.xlsx).

1. The [extract_sourcedata.m](code/extract_sourcedata.m) Script that extracts raw data and converts it into individual subjects. 
2. The [Staygo2_TSV_Converter.m](code/Staygo2_TSV_Converter.m) Extracts task data from each subject and converts it into BIDS format. 
3. The [Stago2_TSV_Comprehension.m](code/Stago2_TSV_Comprehension.m) Extracts comprehension checks (yes/no decision and value predicted) 
4. The [StayGo2_extract_phenotypes.m](code/StayGo2_extract_phenotypes.m) Specifies survey data in our sample for each participant. 
5. The [StayGo2_Surveys_Scored.m](code/StayGo2_Surveys_Scored.m) Scores the participants survey responses into outputs for analysis.
