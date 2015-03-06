#set working directory
setwd("C:/Users/Ruth/Documents")
#read data frame
mydf<- read.table("household_power_consumption.txt", sep=";",header=T)

#subset data frame 

newdata <- rbind(mydf[ which(mydf$Date== "1/2/2007"), ],mydf[ which(mydf$Date== "2/2/2007"), ])

#Coerce factor variables to numeric to do the graphics

newdata$Global_active_power <-as.numeric(as.character(newdata$Global_active_power))

par(mfrow=c(1,1))

##PLOT 1
########

attach(newdata)
hist(Global_active_power,xlab ="Global Active Power (Kilowatts)",
     ylab= "Frequency",
     ylim =c(0,1200),
     main = "Global Active Power", col="red")
