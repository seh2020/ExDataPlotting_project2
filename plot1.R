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

## question 1 
totpm25 <- aggregate(Emissions ~ year, NEI, FUN=sum)
barplot(height=totpm25$Emissions/1000000, names.arg=totpm25$year, xlab="Year", ylab=expression('Total PM2.5 Emission (x 10^6 tons)'))

png("plot1.png") ## plot1
barplot(height=totpm25$Emissions/1000000, names.arg=totpm25$year, xlab="Year", ylab=expression('Total PM2.5 Emission (x 10^6 tons)'))
dev.off() 