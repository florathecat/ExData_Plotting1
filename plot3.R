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
png("plot3.png", width=480, height=480, units="px", res=120)
par(cex.lab=0.8, cex.axis=0.8)

#draw plot 3, first without tickmarks and labeling at x axis
plot3 <- plot(dates, hpc2$Sub_metering_1, type="l", ylab = "Energy sub metering", xaxt="n", xlab=NA)

#somehow because I had set the x axis in plot 2 I actually don't have to set it again in plot 3.
#but I will set it again (xaxt="n", xlab=NA, put markings on x axis, etc.)
axis(1, c("Thu", "Fri", "Sat"), at= c(min(dates), dates[which(dates== "2007-02-02 00:00:00 EST")],
                                      max(dates)+1))

lines(dates, hpc2$Sub_metering_2, type="l", col="red")
lines(dates, hpc2$Sub_metering_3, type="l", col="blue")
legend("topright", names(hpc2)[7:9], lty=1, col=c("black", "red", "blue"), cex=0.7)

dev.off()