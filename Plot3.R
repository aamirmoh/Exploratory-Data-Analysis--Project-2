#load the National Inventory and Source Classification Codes
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset the NEI data to include Emissions and Year
#NEIPlot1 <- NEI[,c("Emissions","year")]
library(dplyr) # 

#y <- NEI %>% 
#  filter(fips =="24510") %>% 
#  group_by(year,type) %>% summarise(TotalEmissions=sum(Emissions))

library(ggplot2)
y <- NEI %>% 
  filter(fips =="24510") %>% 
      group_by(year,type) %>% summarise(TotalEmissions=sum(Emissions))

#below produces the same plot, but i like the one above
#qplot(year,TotalEmissions,data = y,geom = "line", facets = ".~type")
#start graphics device
png(filename = "plot3.png",width = 480, height = 480, units = "px")
qplot(year,TotalEmissions,data = y,col=type,geom = "line" , main = "Sources (point,nonpoint,onroad,nonroad) - Baltimore City")
dev.off()


