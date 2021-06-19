NEI <- readRDS("./datasciencecoursera/Exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./datasciencecoursera/Exploratory Data Analysis/Source_Classification_Code.rds")

total_emissions <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

png(filename='./datasciencecoursera/Exploratory Data Analysis/plot1.png')

plot(total_emissions$Category, total_emissions$x,
        xlab='Year', ylab='Emission Amount',
        main='Total Emissions in 1999, 2002, 2005, and 2008', type='l')

dev.off()