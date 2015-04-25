#############################################################
## VITOR FLISCH CAVALANTI
## 25-APR-15
## DATA SCIENCE SPECIALIZATION - JHU
## Exploratory Data Analysis
## Plot 4
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


## 4) 
## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

## Getting the Coal members
coal.scc <- SCC.DT[grep("Coal", SCC.Level.Three), SCC]

## Filter only the Coal
coal.emissions <- NEI.DT[SCC %in% coal.scc, sum(Emissions),by = "year"]

## Changing the Column Names
setnames(coal.emissions,"year","Year")
setnames(coal.emissions,"V1","Emissions")

png(filename='plot4.png', 
    width=480, 
    height=480,
    units='px')

## Plotting
qplot(Year, 
      Emissions, 
      data =coal.emissions, 
      geom = c("point", "line"), 
      ylab= "Total Emissions, PM 25", 
      xlab = "Year", 
      main = "Annual Total Emissions from Coal Combustion")

dev.off()