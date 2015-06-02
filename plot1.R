DataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(DataUrl, destfile ="HouseholdPowerComsumptionData.zip")

unzip("HouseholdPowerComsumptionData.zip")

hpc <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", 
                stringsAsFactors=FALSE)
hpc2 <- hpc[min(which(hpc$Date == "1/2/2007")):max(which(hpc$Date == "2/2/2007")),]

#open a png device to draw and save plot in png format with indicated specifications
png("plot1.png", width=480, height=480, units="px", res=120)

plot1 <- hist(hpc2$Global_active_power, col = "red", main = "Global Active Power", 
              xlab ="Global Active Power (kilowatts)")

dev.off()