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


## question 6
vehiclesrelated <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehiclesrelated,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

VehiclesNEIBal <- vehiclesNEI[vehiclesNEI$fips=="24510",]
VehiclesNEILA <- vehiclesNEI[vehiclesNEI$fips=="06037",]


vehicleEmission_city <- ddply(VehiclesNEIBal_LA, .(year, fips), function(x) sum(x$Emissions))
colnames(vehicleEmission_city)[3] <- "Emissions"
VehiclesNEIBal$city <- "Baltimore"
VehiclesNEILA$city <- "Los Angeles"
VehiclesNEIBal_LA <- rbind(VehiclesNEIBal, VehiclesNEILA)
dim(VehiclesNEIBal)
dim(VehiclesNEILA)
dim(VehiclesNEIBal_LA)

png("plot6.png")
ggplot(VehiclesNEIBal_LA, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  facet_grid(scales="free", .~city) +
  xlab("year")+ ylab("Total PM2.5 Emissions (in tons)")
dev.off()

##Question6: Between motor vehicle sourced emission of Baltimore and Los Angeles, Which city has seen greater changes over time in motor vehicle emissions?
##Answer: Baltimore