
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

# formating the date time
data.filtered$Datetime <- as.POSIXct(paste(as.Date(data.filtered$Date), data.filtered$Time))

# generating graphic
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# graphic 1
plot(data.filtered$Global_active_power~data.filtered$Datetime, type="l", ylab="Global Active Power", xlab="")

# graphic 2
plot(data.filtered$Voltage~data.filtered$Datetime, type="l", ylab="Voltage", xlab="")

# graphic 3
plot(data.filtered$Sub_metering_1~data.filtered$Datetime, type="l", ylab="Energy sub metering", xlab="")
# red lines
lines(data.filtered$Sub_metering_2~data.filtered$Datetime,col='Red')
# blue lines
lines(data.filtered$Sub_metering_3~data.filtered$Datetime,col='Blue')
# legends
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# graphic 4
plot(data.filtered$Global_reactive_power~data.filtered$Datetime, type="l", ylab="Global_rective_power",xlab="")

# save to file
dev.copy(png, file="plot4.png", height=480, width=480)

dev.off()
