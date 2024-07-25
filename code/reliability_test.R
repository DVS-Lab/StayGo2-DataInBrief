library("readxl")
library("ggplot2")
library("ggpubr")
library("reshape2")
library("emmeans")
library("hrbrthemes")
library("umx")
library("interactions")
library("car")
library("readr")
library("psych")

abis <- read_tsv("A:/Data/StayGo2-DataInBrief/bids/phenotype/abbreviated_impulsiveness_scale.tsv")

abis_mat = data.matrix(abis)
test_abis = abis_mat[2:360,2:13] # Eliminated the participant column
omega(test_abis)

promis <- read_tsv("A:/Data/StayGo2-DataInBrief/bids/phenotype/promis_questionnaire.tsv")

promis_mat = data.matrix(promis)
test_promis = abis_mat[2:360,2:7] # Eliminated the participant column
omega(test_promis)

sevenup_sevendown <- read_tsv("A:/Data/StayGo2-DataInBrief/bids/phenotype/sevenup_sevendown_questionnaire.tsv")
sevenup <- data.frame (sevenup_sevendown$susd_q1,sevenup_sevendown$susd_q3, sevenup_sevendown$susd_q4,sevenup_sevendown$susd_q6,sevenup_sevendown$susd_q7,sevenup_sevendown$susd_q8,sevenup_sevendown$susd_q13)
sevendown <- data.frame (sevenup_sevendown$susd_q2,sevenup_sevendown$susd_q5,sevenup_sevendown$susd_q9,sevenup_sevendown$susd_q10,sevenup_sevendown$susd_q11,sevenup_sevendown$susd_q12,sevenup_sevendown$susd_q14)
omega(sevenup)
omega(sevendown)

ecog <- read_tsv("A:/Data/StayGo2-DataInBrief/bids/phenotype/everyday_cognition_questionnaire.tsv")
ecog_mat = data.matrix(ecog)
test_ecog = abis_mat[2:360,2:12] # Eliminated the participant column
omega(test_ecog)

dospert <- read_tsv("A:/Data/StayGo2-DataInBrief/bids/phenotype/domain_specific_risk_taking_scale.tsv")
dospert_mat = data.matrix(dospert)
dospert_test = dospert_mat[2:360,2:30] # Eliminated the participant column
omega(dospert_test)

loneliness <- read_tsv("A:/Data/StayGo2-DataInBrief/bids/phenotype/loneliness_questionnaire.tsv")
loneliness_mat = data.matrix(loneliness)
loneliness_test = loneliness_mat[2:360,2:4] # Eliminated the participant column
omega(loneliness_test)