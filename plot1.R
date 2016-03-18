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

## Plot 1
hist(tb_power_cons$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()


