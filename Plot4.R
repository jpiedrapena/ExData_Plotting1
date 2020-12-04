#install.packages("data.table")
library(data.table)

#Read data set
data <- fread(input = "household_power_consumption.txt", na.strings="?")

data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

with(data, plot(dateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(data,plot(dateTime,Voltage, type="l", xlab="datetime", ylab="Voltage"))

with(data, plot(dateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(dateTime, Sub_metering_2, col="red"))
with(data, lines(dateTime, Sub_metering_3,col="blue"))
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

with(data, plot(dateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()
