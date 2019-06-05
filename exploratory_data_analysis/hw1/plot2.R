png(filename = "plot2.png", width = 480, height = 480, units = "px")

data <- read.table("./household_power_consumption.txt", header=T, sep=";")

data = data[(strptime(data$Date, '%d/%m/%Y') >= strptime('01/02/2007', '%d/%m/%Y') & strptime(data$Date, '%d/%m/%Y') <=  strptime('02/02/2007', '%d/%m/%Y')),]

data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S') 

plot(data$dateTime, as.numeric(as.character(data$Global_active_power)), type='l', xlab='', ylab='Global Active Power (kilowatts)')

dev.off()