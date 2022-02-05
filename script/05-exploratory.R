########################################
# read csv data from github
########################################

source("01-read-preprocess-data.R")
source("theme-sr.R")

# a certain telco's brand colors: from red to yellow
#
# #AA1937 (dark red)
# #E6003C
# #FAA600
# #FFC805 (bright yellow)

# I should fancify the graphics later with corporate colors:
# https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2

summary(dat)

# some presentation-ready figures on the variable distributions first

##############################
# images of all the factors 
##############################

dat1 <- dat %>%
		select(!(contains(c("Charges", "tenure", "customerID"))))

for (predictor in names(dat1)){
				#print(predictor)
	dfplot <- dat1 %>%
		select(predictor) %>%
		mutate(value=.[[1]]) %>%
		group_by(value) %>%
		#group_by_at(vars(one_of(predictor))) %>%
		summarise(counts=n()) 

#		print(str(dfplot))

	p1 <- ggplot(dfplot) +
		geom_col(aes(x=value, y=counts, fill=value), position="dodge", colour='black', alpha=0.75) +
		coord_flip()  +
	  scale_fill_manual(values=col_sr_unnamed, guide = guide_legend(reverse = TRUE))  +
	  labs(title=predictor,
	     y = 'count',
			 x = 'value'
			 ) +
		theme_sr() +
		theme(axis.text.x=element_text(angle=45, hjust=1, vjust=1))

	png(filename=paste(figdirprefix, filedateprefix, "_predictor_", predictor, "-distribution.png", sep=''),
			width=800, height=250)
	 print(p1)
	dev.off()

}

##############################
# images of all the numerics
##############################

dat1 <- dat %>%
		select((contains(c("Charges", "tenure"))))

for (predictor in names(dat1)){

	dfplot <- dat1 %>%
		select(predictor) %>%
		mutate(value=.[[1]])

	p1 <- ggplot(dfplot) +
		geom_histogram(aes(x=value), fill=col_sr_unnamed[1], colour='black', alpha=0.75) +
	  labs(title=predictor, x = 'value', y = 'count') +
		theme_sr() +
		theme(axis.text.x=element_text(angle=0, hjust=0, vjust=1))

	png(filename=paste(figdirprefix, filedateprefix, "_predictor_", predictor, "-distribution.png", sep=''),
			width=800, height=250)
	 print(p1)
	dev.off()

}

##############################
# correlation heatmap
##############################


dfplot <- dat_dummy %>%
					cor() %>%
					melt()

p1 <- ggplot(dfplot) +
		geom_tile(aes(x=Var1, y=Var2, fill=value), alpha=0.89) +
	  labs(title="pairwise correlations between variables", x = '', y = '') +
		theme_sr() +
		scale_fill_continuous(high = col_sr_unnamed[1], low=col_sr_unnamed[4]) +
		theme(axis.text.x=element_text(angle=60, hjust=1, vjust=1))

png(filename=paste(figdirprefix, filedateprefix, "_heatmap-correlations.png", sep=''),
			width=1500, height=1400)
	 print(p1)
dev.off()

# so there are at least some correlations between the factors and churn
#
# also: totalcharges and monthlycharges and tenure are positively correlated


##############################
# highest correlations with Churn
##############################

# filter high correlations with Churn=yes
dfplot_highcor <- dfplot %>%
				filter(Var1=="Churn_Yes" & abs(value)>0.25) %>%
				filter(!(Var2=="Churn_Yes" | Var2=="Churn_No"))

p1 <- ggplot(dfplot_highcor) +
		geom_col(aes(x=Var2, y=value), fill=col_sr_unnamed[2], alpha=0.85) +
	  labs(title="strongest correlations with Churn=Yes", x = '', y = '') +
		theme_sr() +
		coord_flip() +
		#scale_fill_continuous(high = col_sr_unnamed[1], low=col_sr_unnamed[4]) +
		theme(axis.text.x=element_text(angle=0, hjust=0.5, vjust=1))

png(filename=paste(figdirprefix, filedateprefix, "_highest-correlations-with-churn.png", sep=''),
			width=1000, height=500)
	 print(p1)
dev.off()

# okay, there's definitely some information that might help in predicting churn here

##############################
# compare distributions for variables between groups (churn=yes vs. churn=no)
##############################

##############################
# images of all the factors 
##############################

dat1 <- dat %>%
		select(!(contains(c("Charges", "tenure", "customerID"))))

for (predictor in names(dat1)){
	dfplot <- dat1 %>%
		select(predictor,Churn) %>%
		mutate(value=.[[1]]) %>%
		group_by(Churn,value) %>%
		summarise(counts=n()) 

	p1 <- ggplot(dfplot) +
		geom_col(aes(x=Churn, y=counts, fill=value), position="fill", colour='black', alpha=0.75) +
		coord_flip()  +
	  scale_fill_manual(values=col_sr_unnamed, guide = guide_legend(reverse = TRUE))  +
	  labs(title=predictor,
	     y = 'relative distribution',
			 x = 'Churn?'
			 ) +
		theme_sr() +
		theme(axis.text.x=element_text(angle=0, hjust=0.5, vjust=0.5))

	png(filename=paste(figdirprefix, filedateprefix, "_churngroups_predictor_", predictor, "-distribution.png", sep=''),
			width=800, height=250)
	 print(p1)
	dev.off()

}

##############################
# images of the numerics
##############################

dat1 <- dat %>%
		select((contains(c("Charges", "tenure", "Churn"))))

for (predictor in names(dat1)){

	dfplot <- dat1 %>%
		select(predictor, Churn) %>%
		mutate(value=.[[1]])

	p1 <- ggplot(dfplot) +
		geom_density(aes(x=value, y=..density.., fill=Churn), colour='black', alpha=0.75) +
		#coord_flip()  +
	  scale_fill_manual(values=col_sr_unnamed[c(4,1)], guide = guide_legend(reverse = TRUE))  +
	  labs(title=predictor,
	     y = 'relative distribution (sum of area=1)',
			 x = ''
			 ) +
		theme_sr() +
		theme(axis.text.x=element_text(angle=0, hjust=0.5, vjust=0.5))

	png(filename=paste(figdirprefix, filedateprefix, "_churngroups_predictor_numeric_", predictor, "-distribution.png", sep=''),
			width=600, height=550)
	 print(p1)
	dev.off()

}

# some nice figures and relationships here. More in the readme.md.


