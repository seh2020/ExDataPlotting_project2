library(plyr)
library(ggplot2)
library(grid)
library(data.table)
library(dplyr)

## data download

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="~/coursera_ref/test/ExDataPlotting_project2/data.zip")
unzip("data.zip")

NEI<- readRDS("summarySCC_PM25.rds")
head(NEI)


SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

## question 3
Baltimore <- subset(NEI, fips == "24510")
typetotpm25Bal <- ddply(Baltimore, .(year, type), function(x) sum(x$Emissions))
colnames(typetotpm25Bal)[3] <- "Emissions"
p <- qplot(year, Emissions, data=typetotpm25Bal, color=type, geom ="line") + xlab("Baltimore(year)") + ylab("Total PM2.5 Emissions (in tons)")

png("plot3.png") ##plot3
print(p)
dev.off()

##Answer: 'increased ...type(point) in 2005 and 'decreased ...type('non-road', 'nonpoint' and 'on-road')  