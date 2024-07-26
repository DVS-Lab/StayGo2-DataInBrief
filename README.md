[![DOI](https://zenodo.org/badge/811528780.svg)](https://zenodo.org/doi/10.5281/zenodo.11513694)

# StayGo Data
This repository contains the final code for managing and processing all of the data in our StayGo project. A preprint of a data paper has been posted to PsyArxiv ((https://osf.io/preprints/psyarxiv/x8fu6)) and is under consideration at Data in Brief.

## Prerequisites and Recommendations
1. Understand BIDS (see: https://bids.neuroimaging.io/specification.html)
2. Install MATLAB or OCTAVE and LibreOffice.

This repository contains the sourcedata (raw deidentified participant information), the scripts to extract the survey and behavioral data, along with the data formatted to BIDS specification. To access the data, go the [bids](bids) folder. Both the decisions made in the Gold Mine task and the subsequent Comprehension Checks live under each participant folder. The survey data is organized within the [phenotype](phenotype) folder. The data is in TSV format and can be easily read into any analysis program (or into a spreadsheet software like LibreOffice). Additionally, per BIDS specification we include metadata files in .JSON format. These files can be opened with any text editor and serve as a data dictionary for each file type included.

If you wish to reproduce the data extraction, you can access the raw Qualtrics output file in [sourcedata](bids/sourcedata) and follow the steps described later in the README to run the scripts in the [code](code) directory. The scripts were generated in MATLAB, though they can be run as well in Octave, an open source alternative.

Note: If using OCTAVE, you must download the "io" package. Use "pkg install -forge io" in the commandline to install.

Some of the contents of this repository are not tracked (.gitignore) because the files are large and we do not yet have a nice workflow for datalad. Note that we only track key text files in bids.

## Tracked folders and their contents
1. [code](code): extraction scripts lives in the code directory.
2. [bids](bids): data lives in the bids directory containing the standardized "raw data" in BIDS format in (sourcedata).

Within the bids subdirectory, we include the following tracked folders:

3. [phenotypes](bids/phenotypes): Psychosocial measures of behavior. This folder includes survey data for each participant. Included are ABIS, DOSPERT, ECOG, Loneliness, PROMIS, and SevenUp SevenDown.
4. [sourcedata](bids/sourcedata): behavioral data from the predictive decision-making task. Participants are ordered in folders of sub-001 through sub-360. 

## Code 
1. The [extract_sourcedata.m](code/extract_sourcedata.m) Script that extracts raw data and converts it into individual subjects. 
2. The [StayGo2_TSV_Converter.m](code/StayGo2_TSV_Converter.m) Extracts task data from each subject and converts it into BIDS format. 
3. The [StayGo2_TSV_Comprehension.m](code/StayGo2_TSV_Comprehension.m) Extracts comprehension checks (yes/no decision and value predicted) 
4. The [StayGo2_extract_phenotypes.m](code/StayGo2_extract_phenotypes.m) Specifies survey data in our sample for each participant. 
5. The [StayGo2_Surveys_Scored.m](code/StayGo2_Surveys_Scored.m) Scores the participants survey responses into outputs for analysis.
6. The[survey_questions.docx](code/survey_questions.docx) is a reference file to access the stimuli/questionnaires participants experienced.
7. The [StayGo2.qsf](code/StayGo2.qsf) is the Qualtrics survey implemented. Upload it directly to Qualtrics to preview or reproduce the survey.

## Conversion of Sourcedata to BIDS Format
The [Qualtrics_sourcedata.xlsx](bids/sourcedata/Qualtrics_sourcedata.xlsx) file contains all of the deidentified source data used in this project.

The data was processed and converted to BIDS format using the following steps.

1. Downloaded from Qualtrics and deidentified. We excluded the following columns to minimize the risk of identification: IP address, response ID, Location (longitude), Location (latitude), childhood city, and childhood zipcode.
2. Extracted sourcedata using [extract_sourcedata.m](code/extract_sourcedata.m). This step creates an identifier for each participant and places their data within a folder in sourcedata.
3. Converted behavioral data from sourcedata into bids format using [StayGo2_TSV_Converter.m](code/StayGo2_TSV_Converter.m). This code outputs a *-beh.tsv file for each participant subfolder in the bids directory. 
4. Converted comprehension check data from sourcedata into bids format using [StayGo2_TSV_Comprehension.m](code/StayGo2_TSV_Comprehension.m). This code outputs a *-comprehension_checks.tsv and *-comprehension_decision.tsv file for each participant subfolder in the bids directory. 
5. Generated phenotypes using [StayGo2_extract_phenotypes.m](code/StayGo2_extract_phenotypes.m) in bids format in the bids/phenotypes directory. Additionally, this script generates a participants.tsv file in the bids directory.

## Downloading Data
To get data via github:
```
git clone https://github.com/DVS-Lab/StayGo2-DataInBrief
cd StayGo2-DataInBrief
```

## Acknowledgments
This work was supported in part by grants from the National Institute on Aging (RF1-AG067011 to DVS). We thank Ishika Kohli and Amanda Nguyen for assistance with data collection. We also thank Cooper Sharp for helping validate the dataset through the BIDS validator.
