## Read Data
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings= "?")

## Convert Date column to Date Format and add it as new column
myNewData <- cbind(mydata, newDate=as.Date(mydata$Date, "%d/%m/%Y"))

## Filter Data
d <- subset(myNewData, myNewData$newDate == as.Date("01/02/2007", "%d/%m/%Y"))
ds <- rbind(d, subset(myNewData, myNewData$newDate == as.Date("02/02/2007", "%d/%m/%Y")))

## Add datetime column
ds1 <- cbind(ds, newTime=strptime(paste(ds$Date, ds$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

## Remove original Data as its not required further
rm(mydata)
rm(myNewData)

## Plot 2
png(file="plot2.png", width=480, height=480)
plot(ds1$newTime, ds1$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()
