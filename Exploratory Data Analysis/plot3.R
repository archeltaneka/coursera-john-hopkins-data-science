library(ggplot2)
library(plyr)

NEI <- readRDS("./datasciencecoursera/Exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./datasciencecoursera/Exploratory Data Analysis/Source_Classification_Code.rds")

maryland_subset <- subset(NEI, fips=='24510')
total.emissions <- ddply(maryland_subset, .(year, type), function(data) sum(data$Emissions))

png(filename='./datasciencecoursera/Exploratory Data Analysis/plot3.png')

qplot(year, V1, data=total.emissions, color=type, geom='line') + xlab('Year') +
  ylab('Total Emissions') + ggtitle('Total Emissions (Baltimore) in 1999, 2002, 2005, and 2008')

dev.off()