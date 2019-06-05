png(filename = "plot3.png", width = 480, height = 480, units = "px")

data <- read.table("./household_power_consumption.txt", header=T, sep=";")

data = data[(strptime(data$Date, '%d/%m/%Y') >= strptime('01/02/2007', '%d/%m/%Y') & strptime(data$Date, '%d/%m/%Y') <=  strptime('02/02/2007', '%d/%m/%Y')),]

data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S') 

plot(data$dateTime, as.numeric(as.character(data$Sub_metering_1)), type='l', xlab='', ylab='Energy sub metering')
points(data$dateTime, as.numeric(as.character(data$Sub_metering_2)), type='l', col='red')
points(data$dateTime, as.numeric(as.character(data$Sub_metering_3)), type='l', col='blue')

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))

dev.off()