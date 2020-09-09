##
## Filename: plot4.R
## Author: Christopher Lim
## Purpose: Coursera Data Science - Exploratory Data Analysis Course Project 1
##
## The below script is run using RGUI 4.0.2 and requires the data.table library
##

library(data.table)

srcDataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
srcDataFileZip <- "household_power_consumption.zip"
srcDataFile <- "household_power_consumption.txt"

# Download the zip file and unzip if it does not already exist
if (!file.exists(srcDataFile)) {
  download.file(srcDataUrl, srcDataFileZip, mode = "wb")
  unzip(srcDataFileZip)
}

# Read power consumption data from file
powerDF <- fread(srcDataFile, header=TRUE, sep=";", na.strings= "?", data.table="FALSE")

# Extract the required period from data frame 
powerDF <- subset(powerDF, Date %in% c("1/2/2007", "2/2/2007")) 

# Create a DataTime (POSIXlt) column from Date and Time strings
powerDF$DateTime = strptime(paste(powerDF$Date, powerDF$Time), "%d/%m/%Y %H:%M:%S")

# Open a PNG file device to output chart
png(file="plot4.png", width=480, height=480, bg = "white")

# Create multi plot chart into PNG file device

# Initialise 2x2 plot window
par(mfrow = c(2,2))

# Create top left plot
with(powerDF, plot(DateTime, Global_active_power, type = "l", main="", xlab = "", ylab = "Global Active Power"))

# Create top right plot
with(powerDF, plot(DateTime, Voltage, type = "l", xlab = "datetime" ))

# Create bottom left plot
with(powerDF, plot(DateTime, Sub_metering_1, type = "l", main = "", xlab = "", ylab = "Energy sub metering"))
with(powerDF, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(powerDF, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))

# Create a legend at the top right corner of chart
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
		col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n", cex = 0.95)

# Create bottom right plot
with(powerDF, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

# Close PNG file device
dev.off()

