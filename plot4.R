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

## question 4

combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

png("plot4.png")
coalcomb <- aggregate(Emissions ~ year, combustionNEI, FUN=sum)
p <- qplot(year, Emissions, data=coalcomb, geom ="line") + xlab("coal_combustions(year)") + ylab("Total PM2.5 Emissions (in tons)")
print(p)
dev.off()

##question4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
## answer: overall Emissions from coal combustion has been decreased from 2002. 