DataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(DataUrl, destfile ="HouseholdPowerComsumptionData.zip")

unzip("HouseholdPowerComsumptionData.zip")

hpc <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", 
                stringsAsFactors=FALSE)
hpc2 <- hpc[min(which(hpc$Date == "1/2/2007")):max(which(hpc$Date == "2/2/2007")),]

#covert date and time using POSIXct function; tz = "time zone"
#note that the date format in original table is in date/month/year
dates <- as.POSIXct(paste(hpc2$Date, hpc2$Time, sep=" "), tz="EST", "%d/%m/%Y %H:%M:%S")

#open a png device to draw and save plot in png format with indicated specifications
png("plot4.png", width=480, height=480, units="px", res=120)

#set plotting parameters; change the size of labeling to smaller ones
par(mfrow=c(2,2))
par(cex=0.5, cex.axis=0.8, cex.lab=0.8)

#draw plots one by one in the order of (1,1), (1,2), (2,1), (2,2)
plot(dates, hpc2$Global_active_power, type="l", xlab="", xaxt="n", ylab="Global Active Power")
axis(1, c("Thu", "Fri", "Sat"), at=c(min(dates), dates[which(dates=="2007-02-02 00:00:00 EST")],
                                       max(dates)+1))

#somehow I don't have to set x axis marking any more after setting it once.
plot(dates, hpc2$Voltage, xlab="datetime", ylab="Voltage", type="l")

plot(dates, hpc2$Sub_metering_1, type="l", xlab="datetime", ylab="Energy sub metering")
lines(dates, hpc2$Sub_metering_2, type="l", col="red")
lines(dates, hpc2$Sub_metering_3, type="l", col="blue")
#there is no border--> set legend border by "bty"; also reduce the legend size
legend("topright", names(hpc2)[7:9], lty=1, col=c("black", "red", "blue"), bty="n", cex=0.8)

plot(dates, hpc2$Global_reactive_power, type="l", xlab="datetime", ylab="Global reactive power")

dev.off()