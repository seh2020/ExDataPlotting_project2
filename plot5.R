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


## question5 
head(SCC)
vehiclesrelated <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehiclesrelated,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
VehiclesNEIBal <- vehiclesNEI[vehiclesNEI$fips=="24510",]

vehicleBal<- aggregate(Emissions ~ year, VehiclesNEIBal, FUN=sum)
png("plot5.png")
p <- qplot(year, Emissions, data=vehicleBal, geom ="line") + xlab("Motor_vehicles(year)") + ylab("Total PM2.5 Emissions (in tons)")
print(p)
dev.off()

##Question5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
##Answer: Motor vehicle sourced emission in Baltomore has been significantly decreased from 2002. 