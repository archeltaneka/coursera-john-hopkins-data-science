library(ggplot2)
library(plyr)

NEI <- readRDS("./datasciencecoursera/Exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./datasciencecoursera/Exploratory Data Analysis/Source_Classification_Code.rds")

vehicle.source <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
vehicle.source2 <- SCC[SCC$EI.Sector %in% vehicle.source,]["SCC"]

# baltimore
baltimore.vehicle <- NEI[NEI$SCC %in% vehicle.source2$SCC & NEI$fips == "24510",]
# LA
losangeles.vehicle <- NEI[NEI$SCC %in% vehicle.source2$SCC & NEI$fips == "06037",]
# baltimore & LA
balt_la.vehicle <- rbind(baltimore.vehicle, losangeles.vehicle)

em.county <- aggregate(Emissions ~ fips * year, data=balt_la.vehicle, FUN=sum)
em.county$county <- ifelse(em.county$fips == '06037', 'Los Angeles', 'Baltimore')

## Step 4: Plot to png
png("./datasciencecoursera/Exploratory Data Analysis/plot6.png")
qplot(year, Emissions, data=em.county, geom="line", color=county) + 
  ggtitle("Motor Vehicle Emissions (Baltimore & LA) from 1999-2002") + xlab("Year") + ylab("Total Emissions")
dev.off()