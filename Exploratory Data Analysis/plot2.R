NEI <- readRDS("./datasciencecoursera/Exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./datasciencecoursera/Exploratory Data Analysis/Source_Classification_Code.rds")

maryland_subset <- subset(NEI, fips=='24510')
total.emissions <- tapply(maryland_subset$Emissions, maryland_subset$year, sum, na.rm=TRUE)

png(filename='./datasciencecoursera/Exploratory Data Analysis/plot2.png')

plot(names(total.emissions), total.emissions,
        xlab='Year', ylab='Emission Amount in',
        main='Total Emissions (Baltimore) in 1999, 2002, 2005, and 2008', type='l')

dev.off()
