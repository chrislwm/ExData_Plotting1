##
## Filename: plot1.R
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
powerDT <- fread(srcDataFile, header=TRUE, sep=";", na.strings= "?")

# Extract the required period from data table
powerDT <- subset(powerDT, Date %in% c("1/2/2007", "2/2/2007")) 

# Open a PNG file device to output chart
png(file="plot1.png", width=480, height=480, bg = "white")

# Create histogram into PNG file device
with(powerDT, hist(Global_active_power, col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)"))

# Close PNG file device
dev.off()

