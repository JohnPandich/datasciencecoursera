library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <-NEI[NEI$fips=="24510",]   
dataSplit <- split(data, data$type)

typePlot <- ggplot()

typePlotData = data.frame(matrix(ncol = 3, nrow = 0))
colnames(typePlotData) <- c("x", "y", "type")
for(typeName in names(dataSplit)){
  typeData <- dataSplit[[typeName]]
  year <- typeData$year
  typeData <- rowsum(typeData$Emissions, group=year)
  typeData <- data.frame(unique(year), typeData[,1], typeName)
  colnames(typeData) <- c("x", "y", "type")
  typePlotData <- merge(typePlotData, typeData, all=TRUE)
}

typePlot <- typePlot + geom_smooth(data=typePlotData, aes(x=x, y=y, color=type)) 
typePlot <- typePlot + xlab("Year")
typePlot <- typePlot + ylab("PM 2.5")
typePlot <- typePlot + ggtitle("PM 2.5 emissions by type in the Baltimore City, Maryland")

ggsave(filename = "plot3.png", typePlot, device="png")
