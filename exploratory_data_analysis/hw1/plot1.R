png(filename = "plot1.png", width = 480, height = 480, units = "px")

data <- read.table("./household_power_consumption.txt", header=T, sep=";")

data = data[(strptime(data$Date, '%d/%m/%Y') >= strptime('01/02/2007', '%d/%m/%Y') & strptime(data$Date, '%d/%m/%Y') <=  strptime('02/02/2007', '%d/%m/%Y')),]

hist(as.numeric(as.character(data$Global_active_power)), xlab='Global Active Power (kilowatts)', ylab='Frequency', col='red', main="Global Active Power")

dev.off()
