#reading the text file from read.table and writing the cleaned data.
Project <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

#selecting data from the dates 2007-02-01 and 2007-02-02.
Project <- Project[Project$Date=='1/2/2007' | Project$Date=='2/2/2007',]
cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity', 'SubMetering1','SubMetering2','SubMetering3')
colnames(Project) <- cols
library(lubridate)
Project$Date<- dmy(Project$Date)
time <- hms(Project$Time)
day<-Project$Date+time
days <- as.POSIXlt(day)
Project <- cbind(Project, days)
write.table(Project, file="household_power_consumption.txt",sep="|",row.names=FALSE)
#Plot 4:
color <- c('black', 'red', 'blue')
label <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
png(filename='plot4.png',width=480,height=480,units='px')
par(mfrow=c(2,2))
plot(Project$days,Project$GlobalActivePower,ylab='Global Active Power',xlab='',type='l')
plot(Project$days,Project$Voltage,ylab='Voltage',xlab='datetime',type='l')
plot(Project$days,Project$SubMetering1, xlab='', ylab='Energy sub metering', type='l', col=color[1])
lines(Project$days, Project$SubMetering2, col=color[2])
lines(Project$days, Project$SubMetering3, col=color[3])
legend('topright', legend = label, col = color, lty = 'solid')
plot(Project$days, Project$GlobalReactivePower,xlab='datetime',ylab='Global_reactive_power',type='l')
dev.off()