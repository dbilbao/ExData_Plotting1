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
setwd("C:/Users/Ruth/ExData_plotting2")

# There is no normality in Emissions,so media per year was considered the appropiate statistic.


###################################################################
##############graficar la evolución emisiones de MOTOR VEHICLES IN BALTIMORE sources
###################################################################

subsetbaltimore2<- subset(summary, fips  == "24510" ) 
subsetLA<- subset(summary, fips  == "06037" ) 
a<-rbind(subsetbaltimore2,subsetLA)


subsetmot<-subset(a, grepl("Veh", a$Short.Name))

library(ggplot2)

png("plot6.png")
qplot(as.factor(year),Emissions,data=a, 
      geom="boxplot",facets=.~fips,ylim=c(0,1),
      na.rm=T,main="Baltimore(24510); LA ( 06037)"
      ,xlab="Year")
dev.off()
