#load the National Inventory and Source Classification Codes
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset the NEI data to include Emissions and Year
#NEIPlot1 <- NEI[,c("Emissions","year")]
library(dplyr) # 
library(ggplot2)
#merge NEI and SCC datasets

#grep for coal in the Short.Name field
foundcoalLogical <- grep("coal",SCC$Short.Name, ignore.case = TRUE,value=FALSE)
z <- as.character(SCC[foundcoalLogical,1]) #z is character array i can pass to filter below 

y <- NEI %>% 
  filter(SCC %in% z) %>% 
      group_by(year) %>% summarise(TotalEmissions=sum(Emissions))

png(filename = "plot4.png",width = 480, height = 480, units = "px")
qplot(year,TotalEmissions,data = y,geom = "line" , main = "United States - Coal Cumbustion")

dev.off()


#plot(y$year,y$TotalEmissions,pch=20 , xlab = "Year",ylab = "Total-Emission/Yr", main = "United States - Coal Cumbustion")
#abline(lm(y$TotalEmissions~y$year))

#below produces the same plot, but i like the one above
#qplot(year,TotalEmissions,data = y,geom = "line")
#start graphics device
#png(filename = "plot3.png",width = 480, height = 480, units = "px")
#qplot(year,TotalEmissions,data = y,col=type,geom = "line" , main = "Sources (point,nonpoint,onroad,nonroad) - Baltimore City")
#dev.off()


