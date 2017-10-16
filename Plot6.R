#load the National Inventory and Source Classification Codes
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr) # 
library(ggplot2)

#grep for motor in the Short.Name field. a motorcycle is also a motorvehicle  per dmv definition
#note: I did not use type=="onroad" 
foundmotorLogical <- grep("motor",SCC$Short.Name, ignore.case = TRUE,value=FALSE)
z <- as.character(SCC[foundmotorLogical,1]) #z is character array i can pass to filter below 

y <- NEI %>% 
  filter(SCC %in% z & fips %in% c("24510","06037")) %>% 
      group_by(year,fips) %>% summarise(TotalEmissions=sum(Emissions))
png(filename = "plot5.png",width = 480, height = 480, units = "px")
qplot(year,TotalEmissions,data = y,geom = "line" , main = "Baltimore City - Motor Vehicle Emissions")
dev.off()


#plot(y$year,y$TotalEmissions,pch=20 , xlab = "Year",ylab = "Total-Emission/Yr", main = "United States - Coal Cumbustion")
#abline(lm(y$TotalEmissions~y$year))

#below produces the same plot, but i like the one above
#qplot(year,TotalEmissions,data = y,geom = "line")
#start graphics device
#png(filename = "plot3.png",width = 480, height = 480, units = "px")
#qplot(year,TotalEmissions,data = y,col=type,geom = "line" , main = "Sources (point,nonpoint,onroad,nonroad) - Baltimore City")
#dev.off()


