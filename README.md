# StayGo Data

This repository contains the final code for managing and processing all of the data in our StayGo project. A preprint of a data paper has been posted to PsyArxiv (UPDATE) and is under consideration at Data in Brief.

## Prerequisites and Recommendations:

1. Understand BIDS 
2. Install MATLAB

Some of the contents of this repository are not tracked (.gitignore) because the files are large and we do not yet have a nice workflow for datalad. Note that we only track key text files in bids.

## Tracked folders and their contents:

code: analysis code
bids: contains the standardized "raw data" in BIDS format 

Within the bids subdirectory, we include the following tracked folders:

phenotypes: Psychosocial measures of behavior. This folder includes survey data for each participant. Included are ABIS, DOSPERT, ECOG, Loneliness, PROMIS, and SevenUp SevenDown.
sourcedata: behavioral data from the predictive decision-making task.

sourcedata, participants are ordered in folders of sub-001 through sub-360. Additionally, we include a rawdata subdirectory that assigned participant numbers from the sourcedata file.

## Code 

1. extract_sourcedata.m: Script that extracts raw data and converts it into individual subjects. 
2. Staygo2_TSV_Converter.m: Extracts task data from each subject and converts it into BIDS format. 
3. Stago2_TSV_Comprehension.m: Extracts comprehension checks (yes/no decision and value predicted) 
4. StayGo2_extract_phenotypes.m: Specifies survey data in our sample for each participant. 
5. StayGo2_Surveys_Scored.m: Scores the participants survey responses into outputs for analysis.

## Meta Data

Qualtrics Meta_Data.xlsx: This is the raw excel file extracted from Qualtrics with all deidentified participant information. It lives in the sourcedata directory.

## Downloading Data:

 get data via github
git clone https://github.com/DVS-Lab/StayGo-DataInBrief
cd StayGo-DataInBrief

## Acknowledgments:

This work was supported in part by grants from the National Institute on Aging (RF1-AG067011 to DVS). We thank Ishika Kohli and Amanda Nguyen for assistance with data collection.