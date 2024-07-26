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
library("here")

code_dir<-getwd()
main_dir<-dirname(code_dir)
phenotype_dir<-file.path(main_dir, "bids", "phenotype")

file_name = file.path(phenotype_dir,"abbreviated_impulsiveness_scale.tsv")
abis <- read_tsv(file_name)

abis_mat = data.matrix(abis)
test_abis = abis_mat[2:360,2:13] # Eliminated the participant column
omega(test_abis)

file_name = file.path(phenotype_dir,"promis_questionnaire.tsv")
promis <- read_tsv(file_name)

promis_mat = data.matrix(promis)
test_promis = promis_mat[2:360,2:7] # Eliminated the participant column
omega(test_promis)

file_name = file.path(phenotype_dir,"sevenup_sevendown_questionnaire.tsv")
sevenup_sevendown <- read_tsv(file_name )
sevenup <- data.frame (sevenup_sevendown$susd_q1,sevenup_sevendown$susd_q3, sevenup_sevendown$susd_q4,sevenup_sevendown$susd_q6,sevenup_sevendown$susd_q7,sevenup_sevendown$susd_q8,sevenup_sevendown$susd_q13)
sevendown <- data.frame (sevenup_sevendown$susd_q2,sevenup_sevendown$susd_q5,sevenup_sevendown$susd_q9,sevenup_sevendown$susd_q10,sevenup_sevendown$susd_q11,sevenup_sevendown$susd_q12,sevenup_sevendown$susd_q14)
omega(sevenup)
omega(sevendown)


file_name = file.path(phenotype_dir,"everyday_cognition_questionnaire.tsv")
ecog <- read_tsv(file_name)
ecog_mat = data.matrix(ecog)
test_ecog = ecog_mat[2:360,2:12] # Eliminated the participant column
omega(test_ecog)


file_name = file.path(phenotype_dir,"domain_specific_risk_taking_scale.tsv")
dospert <- read_tsv(file_name)
dospert_mat = data.matrix(dospert)
dospert_test = dospert_mat[2:360,2:30] # Eliminated the participant column
omega(dospert_test)

file_name = file.path(phenotype_dir,"loneliness_questionnaire.tsv")
loneliness <- read_tsv(file_name)
loneliness_mat = data.matrix(loneliness)
loneliness_test = loneliness_mat[2:360,2:4] # Eliminated the participant column
omega(loneliness_test)