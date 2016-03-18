## Set directory
setwd("/Users/Vitor/Documents/coursera/data_science/3_get_clean_data/week1")

## Using SQL library
library(data.table)

## Load data into R
tb_power_cons <- fread("household_power_consumption.txt", sep=";", header="auto", na.strings="?",
                        stringsAsFactors=FALSE, 
                        check.names=FALSE, encoding="unknown", strip.white=TRUE, 
                        showProgress=getOption("datatable.showProgress"),
                        data.table=getOption("datatable.fread.datatable")
                  )

## Adjust date before filtering
tb_power_cons$Date <- as.Date(tb_power_cons$Date, format="%d/%m/%Y")
tb_power_cons$Datetime <- as.POSIXct(paste(as.Date(tb_power_cons$Date), tb_power_cons$Time))

## Filter specific dates
tb_power_cons <- subset(tb_power_cons, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(
      tb_power_cons, 
      {
            plot(Global_active_power ~ Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
            plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="")
            plot(Sub_metering_1 ~ Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
            lines(Sub_metering_2 ~ Datetime,col='Red')
            lines(Sub_metering_3 ~ Datetime,col='Blue')
            legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
            plot(Global_reactive_power~Datetime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
      }
)
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


