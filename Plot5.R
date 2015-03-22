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


################################################
##Ahora los mismo pero solo del estado de Maryland fips="24510"

subsetbaltimore<- subset(NEI, fips  == "24510" ) 
dim(subsetbaltimore)

##################################################################
############ WITH GGPLOT VER EMISSIONS TYPE EVOLUTION IN BALTIMORE
##################################################################
library(ggplot2)

png("plot3.png")
qplot(as.factor(year),Emissions,data=subsetbaltimore, 
      geom="boxplot",facets=.~type,ylim=c(0,1),
      na.rm=T,main="Baltimore; Four Sources Emissions Evolution by year"
      ,xlab="Year")
dev.off()
###################################################################
##############graficar la evolución emisiones de coal-combustion sources
###################################################################

dim(SCC)
pattern<-c("comb","coal")
subsetcomb<-grep("comb",SCC)
names(summary)
subsetcomb<-subset(summary, grepl("Comb", summary$Short.Name))
dim(subsetcombcoal)
subsetcombcoal<-subset(subsetcomb, grepl("Coal", subsetcomb$Short.Name))
is.data.frame(subsetcombcoal)
names(subsetcombcoal)
#Con el subset que contenga comb y coal


#First, we split the count column by the spray column.
emissions_by_year2 <- with(subsetcombcoal, split(Emissions,year))
dim(median_by_year2)
#Secondly, we apply the statistic to each element of the list. Lets use the median here.
median_by_year2 <- lapply(emissions_by_year2, median)

#Finally, (if possible) we recombine the list as a vector.

vector_median_by_year2<-unlist(median_by_year2)
barplot(vector_median_by_year2,col="green",xlab="Year",ylab="Median of PM2.5 by Year"
        ,main= "Evolution of PM2.5 by year,Coal,Combustion related Sources")

###################################################################
##############graficar la evolución emisiones de MOTOR VEHICLES IN BALTIMORE sources
###################################################################

subsetbaltimore2<- subset(summary, fips  == "24510" ) 
dim(subsetbaltimore2)


names(summary)
subsetmot<-subset(subsetbaltimore2, grepl("Veh", subsetbaltimore2$Short.Name))
dim(subsetmot)

#Con el subset que contenga comb y coal


#First, we split the count column by the spray column.
emissions_by_year2 <- with(subsetmot, split(Emissions,year))
dim(median_by_year2)
#Secondly, we apply the statistic to each element of the list. Lets use the median here.
median_by_year2 <- lapply(emissions_by_year2, median)

#Finally, (if possible) we recombine the list as a vector.

vector_median_by_year2<-unlist(median_by_year2)
barplot(vector_median_by_year2,col="purple",xlab="Year",ylab="Median of PM2.5 by Year"
        ,main= "Evolution of PM2.5 by year,Motor Vehicles Sources in Baltimore")
