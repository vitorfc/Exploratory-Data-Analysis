#############################################################
## VITOR FLISCH CAVALANTI
## 25-APR-15
## DATA SCIENCE SPECIALIZATION - JHU
## Exploratory Data Analysis
## Plot 3
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


## 3)
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

## Compute the total emissions in baltimore by the Type and Year

total.emissions.baltimore.type <- ddply(NEI.Baltimore, 
                                        .(type,year), 
                                        summarize, 
                                        Emissions = sum(Emissions))

names(total.emissions.baltimore.type) <- c("Pollutant_Type","Year", "Emissions")

png(filename='plot3.png',
    width=480, 
    height=480,
    units='px')

## Plotting
qplot(Year, 
      Emissions, 
      data =total.emissions.baltimore.type, 
      group = Pollutant_Type,
      color = Pollutant_Type, 
      geom = c("point", "line"), 
      ylab= "Total Emissions, PM 25", 
      xlab = "Year", 
      main = "Total Emissions in Baltimore by Type of Pollutant")

dev.off()