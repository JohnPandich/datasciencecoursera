NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
               
data <- rowsum(NEI$Emissions, group=NEI$year)

png("plot1.png", width=480, height=480)
plot(unique(NEI$year), data[,1], type="l", xlab="Year", ylab="PM 2.5", main="PM 2.5 emissions in the United States")
dev.off()
