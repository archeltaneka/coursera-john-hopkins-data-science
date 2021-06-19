library(ggplot2)
library(plyr)

NEI <- readRDS("./datasciencecoursera/Exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./datasciencecoursera/Exploratory Data Analysis/Source_Classification_Code.rds")

vehicle.source <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))

vehicle.source2 <- SCC[SCC$EI.Sector %in% vehicle.source,]["SCC"]

baltimore.vehicle <- NEI[NEI$SCC %in% vehicle.source2$SCC & NEI$fips == "24510",]
baltimore.pm25 <- ddply(baltimore.vehicle, .(year), function(x) sum(x$Emissions))

## Step 4: Plot to png
png("./datasciencecoursera/Exploratory Data Analysis/plot5.png")
qplot(year, V1, data=baltimore.pm25, geom="line") + 
  ggtitle("Motor Vehicle Emissions (Baltimore) by Year") + xlab("Year") + ylab("Total Emissions")
dev.off()