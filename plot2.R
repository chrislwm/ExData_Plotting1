##
## Filename: plot2.R
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
png(file="plot2.png", width=480, height=480, bg = "white")

# Create plot into PNG file device
with(powerDF, plot(DateTime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)"))

# Close PNG file device
dev.off()

