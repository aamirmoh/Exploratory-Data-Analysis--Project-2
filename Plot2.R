#load the National Inventory and Source Classification Codes
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset the NEI data to include Emissions and Year
NEIPlot1 <- NEI[,c("Emissions","year")]
library(dplyr) # 
y <- NEIPlot1 %>% 
  +   group_by(year) %>% summarise(TotalEmissions=sum(Emissions))


#start graphics device
png(filename = "plot1.png",width = 480, height = 480, units = "px")
plot(y$year,y$TotalEmissions,pch=20 , xlab = "Year",ylab = "Total-Emission/Yr", main = "Decrease in Total Measurement")
abline(lm(y$TotalEmissions~y$year))
dev.off()


plot2data <- NEI %>% 
  filter(fips =="24510") %>% 
    group_by(year) %>% summarise(TotalEmissions=sum(Emissions))

