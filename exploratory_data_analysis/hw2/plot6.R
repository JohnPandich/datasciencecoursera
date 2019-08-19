library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mobileSCCs <-SCC[grepl("Mobile", SCC$EI.Sector, ignore.case=TRUE),]$SCC

data <-NEI[NEI$SCC %in% mobileSCCs,]   
data <-data[data$fips=="24510" | data$fips=="06037",]     
data$fips[data$fips=="24510"] <- "Baltimore"
data$fips[data$fips=="06037"] <- "LA"


dataSplit <- split(data, data$fips)

plotData = data.frame(matrix(ncol = 3, nrow = 0))
colnames(plotData) <- c("x", "y", "city")

for(cityName in names(dataSplit)){
  cityData <- dataSplit[[cityName]]
  year <- cityData$year
  cityData <- rowsum(cityData$Emissions, group=year)
  cityData
  cityData <- data.frame(unique(year), cityData[,1], cityName)
  colnames(cityData) <- c("x", "y", "city")
  plotData <- merge(plotData, cityData, all=TRUE)
}

dataPlot <- ggplot()
dataPlot <- dataPlot + geom_smooth(data=plotData, aes(x=x, y=y, color=city)) 
dataPlot <- dataPlot + xlab("Year")
dataPlot <- dataPlot + ylab("PM 2.5")
dataPlot <- dataPlot + ggtitle("PM 2.5 emissions from mobile sources in the Baltimore City and LA")

ggsave(filename = "plot6.png", dataPlot, device="png")