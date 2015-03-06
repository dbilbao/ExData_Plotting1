#set working directory
setwd("C:/Users/Ruth/Documents")
#read data frame
mydata<- read.table("household_power_consumption.txt", sep=";",header=T)
#change name
mydf<-mydata

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





##PLOT 3
########

attach(newdata)
plot(Fecha2,Sub_metering_1,type="l"
     ,ylab ="Energy sub metering"
     ,xlab= "")
lines(Fecha2,Sub_metering_2, col="red")
lines(Fecha2,Sub_metering_3, col="blue")
legend("topright",# places a legend at the appropriate place
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # puts text in the legend
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c(1,"blue","red")) # gives the legend lines the correct color and width

