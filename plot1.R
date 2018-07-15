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
png(filename = "plot1.png", width=480, height = 480, units="px")
with(data, hist(Global_active_power, main="Global Active Power", col="red", xlab = "Global Active Power (kilowatts)"))
dev.off()