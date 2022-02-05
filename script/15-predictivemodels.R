########################################
# try to predict churn 
########################################

source("01-read-preprocess-data.R")
source("05-exploratory.R")

##############################
# build a few models
##############################

model1 <-glm(Churn_num ~ PaymentMethod, binomial(link = "logit"), data=train)
summary(model1)

model2 <-glm(Churn_num ~ InternetService, binomial(link = "logit"), data=train)
summary(model2)

# I could try more models. Hm. I'll just choose from the graphics which
# variables to include in one final model.

# StreamingMovies highly correlated to StreamingTV -> just use one of those

model42 <- glm(Churn_num ~ PaymentMethod + SeniorCitizen + StreamingMovies +
							 TechSupport + Contract + Dependents + DeviceProtection +
							 InternetService + OnlineBackup + OnlineSecurity +
							 PaperlessBilling + Partner + tenure + MonthlyCharges + TotalCharges, binomial(link="logit"), data=train)

prediction42 <- predict(model42, test, type="response")


confusionmatrix <- table(prediction42>0.5, test$Churn)
accuracy <- (confusionmatrix[1,1]+confusionmatrix[2,2])/length(test$Churn)

importances <- varImp(model42) %>%
				mutate(variable = rownames(.),
							 group="model parameters"
							 )

##############################
# plot model summary
##############################

plot_importances <- ggplot(importances) +
	geom_col(aes(x=variable, y=Overall), fill=col_sr_unnamed[4], alpha=0.85) +
	theme_sr() + 
	coord_flip() + 
	labs(title="Churn prediction model, importance of predictors",
			 x = '', y = '')


dfacc <- data.frame(Overall = accuracy, variable="accuracy", group="model performance")
plot_accuracy <- ggplot(dfacc) +
	geom_col(aes(x=variable, y=Overall), fill=col_sr_unnamed[1], alpha=0.85) +
	theme_sr() + 
	#coord_flip() + 
	labs(title="", x = 'model', y = 'accuracy')


p1 <- ggarrange(plot_accuracy, plot_importances, 
								widths = c(1, 8),
					      ncol = 2, nrow = 1)

png(filename=paste(figdirprefix, filedateprefix, "_modelsummary-glm.png", sep=''),
		width=1300, height=600)
 print(p1)
dev.off()

# so, the model has an accuracy of 0.8, which is better than the default naive
# baseline of 0.73 when I'd just predict Churn=No all the time.
 
# the rest is more or less interpretation of the model results using the earlier graphics. see readme.md



