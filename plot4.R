





if (!file.exists("./household_power_consumption.txt") &
    !file.exists("./power.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "./power.zip",
                method = "curl")
  unzip("./power.zip")
} else if (!file.exists("./household_power_consumption.txt") &
           file.exists("./power.zip")) {
  unzip("./power.zip")
}

ep <-
  read.csv(file = "./household_power_consumption.txt", sep = ";", header = TRUE)

ep <- subset(ep, Date == "1/2/2007" | Date == "2/2/2007")

dev.copy(png, "plot4.png")

par(mfrow=c(2,2))

with(
  ep,
  plot(
    strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
    Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power"
  ),
)

with(
  ep,
  plot(
    strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
    Voltage,
    type = "l",
    xlab = "datetime",
    ylab = "Voltage"
  ),
)

with(
  ep,
  plot(
    strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
    Sub_metering_1,
    type = "l",
    xlab = "",
    ylab = "Energy sub metering"
  ),
  xlim = c("Thu", "Fri", "Sat")
)

lines(
  strptime(paste(ep$Date, ep$Time), "%d/%m/%Y %H:%M:%S"),
  ep$Sub_metering_2,
  col = "red",
  type = "l"
)
lines(
  strptime(paste(ep$Date, ep$Time), "%d/%m/%Y %H:%M:%S"),
  ep$Sub_metering_3,
  col = "blue",
  type = "l"
)

legend(
  "topright",
  col = c("black", "red", "blue"),
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  lty = 1,
  lwd = 2
)


with(
  ep,
  plot(
    strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
    Global_reactive_power,
    type = "l",
    xlab = "datetime",
    ylab = "Global Reactive Power"
  ),
)
dev.off()
