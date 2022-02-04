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
				print(predictor)
	dfplot <- dat1 %>%
		select(predictor) %>%
		mutate(value=.[[1]]) %>%
		group_by(value) %>%
		#group_by_at(vars(one_of(predictor))) %>%
		summarise(counts=n()) 

		print(str(dfplot))

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
# images of the numerics
##############################

dat1 <- dat %>%
		select((contains(c("Charges", "tenure", "customerID"))))

for (predictor in names(dat1)){

				print(predictor)
	dfplot <- dat1 %>%
		select(predictor) %>%
		mutate(value=.[[1]])

	p1 <- ggplot(dfplot) +
		geom_histogram(aes(x=value), fill=col_sr_unnamed[1], colour='black', alpha=0.75) +
	  labs(title=predictor, x = 'value' y = 'count',) +
		theme_sr() +
		theme(axis.text.x=element_text(angle=0, hjust=0, vjust=1))

	png(filename=paste(figdirprefix, filedateprefix, "_predictor_", predictor, "-distribution.png", sep=''),
			width=800, height=250)
	 print(p1)
	dev.off()

}

##############################
# next: 
#
# - heatmap 
#
# - figures for each variable in relation to churn
##############################
