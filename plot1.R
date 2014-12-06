## Read Data
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings= "?")

## Convert Date column to Date Format and add it as new column
myNewData <- cbind(mydata, newDate=as.Date(mydata$Date, "%d/%m/%Y"))

## Filter Data
d <- subset(myNewData, myNewData$newDate == as.Date("01/02/2007", "%d/%m/%Y"))
ds <- rbind(d, subset(myNewData, myNewData$newDate == as.Date("02/02/2007", "%d/%m/%Y")))

## Remove original Data as its not required further
rm(mydata)
rm(myNewData)

## Plot 1
png(file="plot1.png", width=480, height=480)
hist(ds$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col="red")
dev.off()
