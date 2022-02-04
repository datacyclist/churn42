########################################
# read csv data from github
########################################

library(tidyverse)
source("theme-vsgls.R")
filedateprefix <- format(Sys.time(), "%Y%m%d")
figdirprefix <- '../figs/'

# The churn data has been sent in a zip file -- it originates from kaggle and
# can also be found in a number of github repos. So I'm getting the data from
# there.

# also directly on kaggle: https://www.kaggle.com/blastchar/telco-customer-churn

datraw <- read_csv(file='https://raw.githubusercontent.com/treselle-systems/customer_churn_analysis/master/WA_Fn-UseC_-Telco-Customer-Churn.csv',
col_types='cflffnffffffffffffnnf')

# nice. formatted and clean data. We'll see.

summary(datraw)

# So those are the customers we have/had in Q1-Q2/2021. I'm supposed to predict
# churn in Q3/2021.

# Any preprocessing goes here.

dat <- datraw 
