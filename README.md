# StayGo Data

This repository contains the final code for managing and processing all of the data in our StayGo project. A preprint of a data paper has been posted to PsyArxiv (UPDATE) and is under consideration at Data in Brief.

## Prerequisites and Recommendations:

1. Understand BIDS 
2. Install MATLAB

Some of the contents of this repository are not tracked (.gitignore) because the files are large and we do not yet have a nice workflow for datalad. Note that we only track key text files in bids.

## Tracked folders and their contents:

code: extraction code lives in the (code) directory.
bids: data lives in the (bids) directory containing the standardized "raw data" in BIDS format in (sourcedata).

Within the bids subdirectory, we include the following tracked folders:

(phenotypes): Psychosocial measures of behavior. This folder includes survey data for each participant. Included are ABIS, DOSPERT, ECOG, Loneliness, PROMIS, and SevenUp SevenDown.
(sourcedata): behavioral data from the predictive decision-making task. Participants are ordered in folders of sub-001 through sub-360. 

## Code 

1. The [extract_sourcedata.m](code/extract_sourcedata.m) Script that extracts raw data and converts it into individual subjects. 
2. The [Staygo2_TSV_Converter.m](code/Staygo2_TSV_Converter.m) Extracts task data from each subject and converts it into BIDS format. 
3. The [Stago2_TSV_Comprehension.m](code/Stago2_TSV_Comprehension.m) Extracts comprehension checks (yes/no decision and value predicted) 
4. The [StayGo2_extract_phenotypes.m](code/StayGo2_extract_phenotypes.m) Specifies survey data in our sample for each participant. 
5. The [StayGo2_Surveys_Scored.m](code/StayGo2_Surveys_Scored.m) Scores the participants survey responses into outputs for analysis.

## Source Data

The [Qualtrics_sourcdata.xlsx](bids/sourcedata/Qualtrics_sourcedata.xlsx) file contains all of the deidentified source data used in this project.

## Downloading Data:

The data was processed using the following steps.

1. Downloaded from Qualtrics and deidentified. We excluded the following columns to minimize the risk of identification: IP address, response ID, Location (longitude), Location (latitude), childhood city, and childhood zipcode.
2. Extracted sourcedata using [extract_sourcedata.m](code/extract_sourcedata.m). This step creates an identifier for each participant and places their data within a folder in sourcedata.
3. Converted behavioral data from sourcedata into bids format using [Staygo2_TSV_Converter.m](code/Staygo2_TSV_Converter.m). This code outputs a *-beh.tsv file for each participant subfolder in the bids directory. 
4. Converted comprehension check data from sourcedata into bids format using [Stago2_TSV_Comprehension.m](code/Stago2_TSV_Comprehension.m). This code outputs a *-comprehension_checks.tsv and *-comprehension_decision.tsv file for each participant subfolder in the bids directory. 
5. Generated phenotypes using [StayGo2_extract_phenotypes.m](code/StayGo2_extract_phenotypes.m) in bids format in the bids/phenotypes directory. Additionally, this script generates a participants.tsv file in the bids directory.

 get data via github
git clone https://github.com/DVS-Lab/StayGo2-DataInBrief
cd StayGo2-DataInBrief

## Acknowledgments:

This work was supported in part by grants from the National Institute on Aging (RF1-AG067011 to DVS). We thank Ishika Kohli and Amanda Nguyen for assistance with data collection.