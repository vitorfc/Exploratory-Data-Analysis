#############################################################
## VITOR FLISCH CAVALANTI
## 25-APR-15
## DATA SCIENCE SPECIALIZATION - JHU
## Exploratory Data Analysis
## Plot 1
#############################################################


setwd("C:/R/Exp/P2")

library(plyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Transform into Data Tables
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

## 1)
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

## Compute the total by year
total.emissions <- with(NEI, 
                        aggregate(Emissions, 
                                  by = list(year), 
                                  sum))

png(filename = "plot1.png", 
    width = 480,
    height = 480, 
    units = "px")

## Plotting
plot(total.emissions, 
     type = "b",
     pch = 18, 
     col = "blue", 
     ylab = "Total Emissions", 
     xlab = "Year", 
     main = "Annual Total Emissions")

dev.off()