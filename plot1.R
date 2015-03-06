#set working directory
setwd("C:/Users/Ruth/Documents")
#read data frame
mydata<- read.table("household_power_consumption.txt", sep=";",header=T)
#change name
mydf<-mydata

#subset data frame 

newdata <- rbind(mydf[ which(mydf$Date== "1/2/2007"), ],mydf[ which(mydf$Date== "2/2/2007"), ])

#Replace NA symbol "?" to "NA"
newdata[newdata == "?"] = "NA"

#create a new variable for day/hour date
newdata$fecha<-NULL
for (i in 1:nrow(newdata) ) {newdata$fecha[i] =
                               paste(newdata$Date[i],newdata$Time[i],sep=" ")}
newdata$Fecha<-as.character(newdata$fecha)

newdata$Fecha2<-strptime(newdata$Fecha,"%d/%m/%Y %H:%M:%S")

#Coerce factor variables to numeric to do the graphics

newdata$Global_active_power <-as.numeric(as.character(newdata
                                                      $Global_active_power))
newdata$Global_reactive_power <-as.numeric(as.character(newdata
                                                        $Global_reactive_power) )
newdata$Voltage <-as.numeric(as.character(newdata$Voltage ))
newdata$Global_intensity  <-as.numeric(as.character(newdata
                                                    $Global_intensity  ))
newdata$Sub_metering_1 <-as.numeric(as.character(newdata$Sub_metering_1 ))
newdata$Sub_metering_2 <-as.numeric(as.character(newdata$Sub_metering_2 ))
newdata$Sub_metering_3 <-as.numeric(as.character(newdata$Sub_metering_3 ))



##PLOT 1
########

attach(newdata)
hist(Global_active_power,xlab ="Global Active Power (Kilowatts)",
     ylab= "Frequency",
     ylim =c(0,1200),
     main = "Global Active Power", col="red")
