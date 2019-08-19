NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

year <- data$year
data <-NEI[NEI$fips=="24510",]               
data <- rowsum(data$Emissions, group=year)

png("plot2.png", width=480, height=480)
plot(unique(year), data[,1], type="l", xlab="Year", ylab="PM 2.5", main="PM 2.5 emissions in the Baltimore City, Maryland")
dev.off()
