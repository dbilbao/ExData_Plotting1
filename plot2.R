#set working directory
setwd("C:/Users/Ruth/Documents")
#read data frame
mydf<- read.table("household_power_consumption.txt", sep=";",header=T)


#subset data frame 


newdata <- rbind(mydf[ which(mydf$Date== "1/2/2007"), ],mydf[ which(mydf$Date== "2/2/2007"), ])

#Replace NA symbol "?" to "NA"
newdata[newdata == "?"] = "NA"

#create a new variable for day/hour date
newdata$fecha<-NULL
for (i in 1:nrow(newdata) ) {newdata$fecha[i] =
                               paste(newdata$Date[i],newdata$Time[i],sep=" ")}
newdata$Fecha<-as.character(newdata$fecha)
#str(newdata$Fecha)
newdata$Fecha2<-strptime(newdata$Fecha,"%d/%m/%Y %H:%M:%S")

#Coerce factor variables to numeric to do the graphics

newdata$Global_active_power <-as.numeric(as.character(newdata$Global_active_power))


##PLOT 2
########

attach(newdata)
plot(Fecha2,Global_active_power,type="l"
     ,ylab ="Global Active Power (Kilowatts)"
     ,xlab= "")
