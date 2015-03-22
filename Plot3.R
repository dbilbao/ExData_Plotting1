################################
####ASSIGNMENT 2 ###############
################################

#Make an object with original directory direction
old.dir<-getwd()

#Read RDS files and create one object per data frame
SCC<-readRDS("Source_Classification_Code.rds", refhook = NULL)
NEI<-readRDS("summarySCC_PM25.rds" , refhook = NULL)

#Join both data frame by scc column value with Merge function.

summary<-merge(SCC,NEI,by="SCC")

# Set Working directory to Assigment 
setwd("C:/Users/Ruth/ExData_plotting1")

# There is no normality in Emissions,so media per year was considered the appropiate statistic.

################################################
##Subset Baltimor Maryland fips="24510"

subsetbaltimore<- subset(NEI, fips  == "24510" ) 

##################################################################
############ With ggplot evolution of Emissions type per year in Baltimore
##################################################################
library(ggplot2)

png("plot3.png")
qplot(as.factor(year),Emissions,data=subsetbaltimore, 
      geom="boxplot",facets=.~type,ylim=c(0,1),
      na.rm=T,main="Baltimore; Four Sources Emissions Evolution by year"
      ,xlab="Year")
dev.off()
