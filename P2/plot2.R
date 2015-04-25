#############################################################
## VITOR FLISCH CAVALANTI
## 25-APR-15
## DATA SCIENCE SPECIALIZATION - JHU
## Exploratory Data Analysis
## Plot 2
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

## 2)
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Filter Baltimore City
NEI.Baltimore<-NEI[which(NEI$fips=="24510"),]

## Compute the Total by year
tot.ems.Baltimore<-with(NEI.Baltimore, 
                        aggregate(Emissions, 
                                  by = list(year), 
                                  sum))
png(filename = "plot2.png", 
    width = 480, 
    height = 480, 
    units = "px")

## Plotting
plot(tot.ems.Baltimore, 
     type = "b",
     pch = 18, 
     col = "red", 
     ylab = "Total Emissions", 
     xlab = "Year",
     main = "Baltimore Total Emissions")

dev.off()