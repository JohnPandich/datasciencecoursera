library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mobileSCCs <-SCC[grepl("Mobile", SCC$EI.Sector, ignore.case=TRUE),]$SCC

data <-NEI[NEI$SCC %in% mobileSCCs,]   
data <-data[data$fips=="24510",]           

year <- data$year
data <- rowsum(data$Emissions, group=year)
data <- data.frame(unique(year), data[,1])
colnames(data) <- c("x", "y")

dataPlot <- ggplot()
dataPlot <- dataPlot + geom_smooth(data=data, aes(x=x, y=y)) 
dataPlot <- dataPlot + xlab("Year")
dataPlot <- dataPlot + ylab("PM 2.5")
dataPlot <- dataPlot + ggtitle("PM 2.5 emissions from mobile sources in the Baltimore City, Maryland")

ggsave(filename = "plot5.png", dataPlot, device="png")