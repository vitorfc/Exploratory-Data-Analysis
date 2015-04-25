#############################################################
## VITOR FLISCH CAVALANTI
## 25-APR-15
## DATA SCIENCE SPECIALIZATION - JHU
## Exploratory Data Analysis
## Plot 5
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

## 5)
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Getting the Vehicle members
motor.vehicle.scc = SCC.DT[grep("[Mm]obile|[Vv]ehicles",
                                EI.Sector), SCC]

## Filter the Vehicle in the DT
motor.vehicle.emissions.baltimore = NEI.DT[SCC %in%motor.vehicle.scc, 
                                           sum(Emissions),
                                           by = c("year", "fips")][fips == "24510"]
## Changing column names
setnames(motor.vehicle.emissions.baltimore,"year","Year")
setnames(motor.vehicle.emissions.baltimore,"V1","Emissions")

png(filename='plot5.png',
    width=480,
    height=480,
    units='px')

## Plotting
qplot(Year, 
      Emissions, 
      data =motor.vehicle.emissions.baltimore, 
      geom = c("point", "line"), 
      ylab= "Total Emissions, PM 25", 
      xlab = "Year", 
      main = "Annual Total Emissions from Vehicles in Baltimore")

dev.off()