#############################################################
## VITOR FLISCH CAVALANTI
## 25-APR-15
## DATA SCIENCE SPECIALIZATION - JHU
## Exploratory Data Analysis
## Plot 6
#############################################################


setwd("C:/R/Exp/P2")

library(plyr)
library(ggplot2)
library(data.table)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)


## 6)
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
## sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes 
## over time in motor vehicle emissions?

## Getting the Vehicle members
motor.vehicle.scc = SCC.DT[grep("[Mm]obile|[Vv]ehicles",
                                EI.Sector), SCC]


## Filtering only Vehicle pollution in LA and Baltimore
motor.vehicle.emissions.ba_la = NEI.DT[SCC %in% motor.vehicle.scc & fips %in% c("24510","06037"), 
                                       sum(Emissions), 
                                       by = c("year", "fips")]

## Changing column names
setnames(motor.vehicle.emissions.ba_la,"year","Year")
setnames(motor.vehicle.emissions.ba_la,"V1","Emissions")

## Create the City column using Mutate
motor.vehicle.emissions.ba_la <- mutate(motor.vehicle.emissions.ba_la, 
                                        City = ifelse(fips=="24510", 
                                                      "Baltimore",
                                                      "Los Angeles"))

png(filename='plot6.png', 
    width=480, 
    height=480,
    units='px')
## Plotting
qplot(Year, 
      Emissions, 
      data=motor.vehicle.emissions.ba_la, 
      color=City,
      geom = c("point", "line"),
      ylab="Total Emissions, PM 25", 
      xlab="Year", 
      main="Total Emissions from Vehicles in Baltimore vs LA")

dev.off()