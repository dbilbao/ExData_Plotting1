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
##############Emissions Evolution MOTOR VEHICLES IN BALTIMORE sources
###################################################################

subsetbaltimore2<- subset(summary, fips  == "24510" ) 

subsetmot<-subset(subsetbaltimore2, grepl("Veh", subsetbaltimore2$Short.Name))


#Con el subset que contenga comb y coal


#First, we split the Emissions by year
emissions_by_year2 <- with(subsetmot, split(Emissions,year))

#Secondly, we apply the statistic to each element of the list. Lets use the median here.
median_by_year2 <- lapply(emissions_by_year2, median)

#Finally, (if possible) we recombine the list as a vector.

vector_median_by_year2<-unlist(median_by_year2)

png("plot5.png")
barplot(vector_median_by_year2,col="purple",xlab="Year",ylab="Median of PM2.5 by Year"
        ,main= "Evolution of PM2.5 by year,Motor Vehicles Sources in Baltimore")
dev.off()
