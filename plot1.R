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
#Plot 1:
#launching png device in working directory with width and height.
png(filename='plot1.png',width=480,height=480,units='px')
#plotting histogram
hist(Project$GlobalActivePower, col = 'red', main='Global Active Power',xlab='Global Active Power (kilowatts)')
#closing the device.
dev.off()