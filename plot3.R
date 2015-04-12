
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
plot(data.filtered$Sub_metering_1~data.filtered$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
lines(data.filtered$Sub_metering_2~data.filtered$Datetime,col='Red')
lines(data.filtered$Sub_metering_3~data.filtered$Datetime,col='Blue')

# put the legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# save to file
dev.copy(png, file="plot3.png", height=480, width=480)

dev.off()
