########################################
# read csv data from github
########################################

library(tidyverse)
library(fastDummies)
library(caret)
library(reshape2)

filedateprefix <- format(Sys.time(), "%Y%m%d")
figdirprefix <- '../figs/'

# The churn data has been sent in a zip file -- it originates from kaggle and
# can also be found in a number of github repos. So I'm getting the data from
# there.

# also directly on kaggle: https://www.kaggle.com/blastchar/telco-customer-churn

datraw <- read_csv(file='https://raw.githubusercontent.com/treselle-systems/customer_churn_analysis/master/WA_Fn-UseC_-Telco-Customer-Churn.csv',
col_types='cflffnffffffffffffnnf')

# Nice. For once, formatted and clean data. We'll see.

summary(datraw)

# So those are the customers we have/had in Q1-Q2/2021. I'm supposed to predict
# churn in Q3/2021.

##############################
# Any preprocessing goes here.
##############################

dat <- datraw  %>%
		drop_na() # remove some lines with NA observations


dat_dummy <- dat %>%
		select(-customerID) %>%
		dummy_cols(remove_selected_columns=TRUE)

##############################
# Create train and test sets
##############################

fulldat <- dat %>%
	  mutate(Churn = ifelse(Churn == 'Yes',1,0))

samplesize <- ceiling(0.80 * nrow(dat))
set.seed(42) # what else could it be?
train_samples <- sample(seq_len(nrow(dat)), replace=FALSE, size = samplesize)

train <- dat[train_samples, ]
test <- dat[-train_samples, ]

# of course: this is a one-off sampling. This has to be repeated a lot of times and
# the prediction error should be summarised afterwards (e.g. averaged).
