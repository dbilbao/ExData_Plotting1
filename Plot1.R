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
setwd("C:/Users/Ruth/ExData_Plotting1")

# There is no normality in Emissions,so media per year was considered the appropiate statistic.

#First, we split the Emissions column by year
emissions_by_year <- with(NEI, split(Emissions, year))

#Secondly, we apply the statistic to each element of the list. Lets use the median here.
median_by_year <- lapply(emissions_by_year, median)

#Finally, we recombine the list as a vector.

vector_median_by_year<-unlist(median_by_year)

#And we make a plot.Copying the plot in assigment file

png("plot1.png")
barplot(vector_median_by_year,col="blue",xlab="Year",ylab="Median of PM2.5 by Year"
        ,main= "Evolution of PM2.5 by year")
dev.off()
