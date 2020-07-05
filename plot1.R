



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

png("plot1.png", width = 480, height = 480)

hist(
  as.numeric(subset(ep, ep$Global_active_power != "?")$Global_active_power),
  xlab = "Global active power(kilowatts)",
  main = "Global Active Power",
  col = "red"
)

dev.off()
