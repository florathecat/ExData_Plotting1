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
png("plot2.png", width=480, height=480, units="px", res=120)

#draw plot 2, first without tickmarks and labeling at x axis
plot(dates, hpc2$Global_active_power, type="l", xaxt="n", xlab=NA, 
              ylab="Global active power (kilowatts)")

#put markings on x axis at the beginning of the two days, and the end of the 2nd day
axis(1, c("Thu", "Fri", "Sat"), at= c(min(dates), dates[which(dates=='2007-02-02 00:00:00 EST')], max(dates)))

dev.off()