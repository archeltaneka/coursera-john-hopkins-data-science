library(ggplot2)
library(plyr)

NEI <- readRDS("./datasciencecoursera/Exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./datasciencecoursera/Exploratory Data Analysis/Source_Classification_Code.rds")

coal_comb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
  "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
   Coal"))
coal_comb.scc2 <- subset(SCC, grepl("Comb", Short.Name) & grepl('Coal', Short.Name))

coal_comb.codes <- union(coal_comb.scc$SCC, coal_comb.scc2$SCC)
coal.comb <- subset(NEI, SCC %in% coal_comb.codes)
coal_comb.pm25 <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

png(filename='./datasciencecoursera/Exploratory Data Analysis/plot4.png')

qplot(year, V1, data=coal_comb.pm25, color=type, geom='line') + geom_line(aes(size='total')) +
  stat_summary(fun='sum', fun.min='sum', fun.max='sum', color='black', aes(shape='total'), geom='line') +
  xlab('Year') + ylab('Total Emissions') + ggtitle('Coal Combustion by Source and Year')

dev.off()