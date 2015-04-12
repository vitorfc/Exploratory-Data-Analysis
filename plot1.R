### Plot 1 - Histogram


# set the main directory
setwd("C:/R/Exp/P1/")

# variable with the name of the database
strFile<-"household_power_consumption.txt"

# reading the data
data<-read.table(strFile, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# transforming the column date to date format
data$Date<- as.Date(data$Date, format="%d/%m/%Y")

# select the work interval
data.filtered <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# removing the dataset from the memory
rm(data)

# Generating Graphic
hist(data.filtered$Global_active_power,main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", ylim=c(0, 1200))

# Save to file
dev.copy(png, file="plot1.png", height=480, width=480)

dev.off()