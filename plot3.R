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

## Arrange data as required for plot
sm1 = data.frame(time=ds1$newTime, meter=ds$Sub_metering_1, f="meter1")
sm2 = data.frame(time=ds1$newTime, meter=ds$Sub_metering_2, f="meter2")
sm3 = data.frame(time=ds1$newTime, meter=ds$Sub_metering_3, f="meter3")
s <- rbind(sm1, sm2)
sub_meter <- rbind(s, sm3)

## Plot 3

png(file="plot3.png", width=480, height=480)

plot(sub_meter$time, sub_meter$meter, xlab="", ylab="Energy sub metering", type="n")
with(subset(sub_meter, sub_meter$f=="meter1"), points(time, meter, type="l", col="black"))
with(subset(sub_meter, sub_meter$f=="meter2"), points(time, meter, type="l", col="red"))
with(subset(sub_meter, sub_meter$f=="meter3"), points(time, meter, type="l", col="blue"))

legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()