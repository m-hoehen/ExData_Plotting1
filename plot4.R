# Download File
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

# Select needed lines (1st and 2nd of February 2007)
needed_lines <- grep("^2/2/2007|^1/2/2007", readLines(unz(temp, "household_power_consumption.txt")))

# Load only lines needed and add headers
header <- read.table(unz(temp, "household_power_consumption.txt"), nrows = 1, header = FALSE, sep =";", stringsAsFactors = FALSE)
data <- read.table(unz(temp, "household_power_consumption.txt"), skip=needed_lines[1], nrows=length(needed_lines), sep=";",header=T)
unlink(temp)
names(data) <- header

# Open PNG device, create plot, close device
png(filename = "plot4.png", width=480, height = 480, units="px")
par(mfrow = c(2, 2))
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
# 1. Top Left plot
with(data, plot(datetime, Global_active_power, type="l", ylab = "Global Active Power", xlab=""))
# 2. Top Right plot
with(data, plot(datetime, Voltage, type="l", ylab = "Voltage"))
# 3. Bottom Left plot
with(data, plot(datetime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab=""))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2.5)
# 4. Bottom Right plot
with(data, plot(datetime, Global_reactive_power, type="l"))

dev.off()