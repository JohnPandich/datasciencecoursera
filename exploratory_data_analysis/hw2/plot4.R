library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalSCCs <-SCC[grepl("Coal", SCC$EI.Sector, ignore.case=TRUE),]$SCC

data <-NEI[NEI$SCC %in% coalSCCs,]   

year <- data$year
data <- rowsum(data$Emissions, group=year)
data <- data.frame(unique(year), data[,1])
colnames(data) <- c("x", "y")

dataPlot <- ggplot()
dataPlot <- dataPlot + geom_smooth(data=data, aes(x=x, y=y)) 
dataPlot <- dataPlot + xlab("Year")
dataPlot <- dataPlot + ylab("PM 2.5")
dataPlot <- dataPlot + ggtitle("PM 2.5 emissions coal sources in the United States")

ggsave(filename = "plot4.png", dataPlot, device="png")