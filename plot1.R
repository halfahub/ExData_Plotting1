##    Description: Measurements of electric power consumption in one household with 
##    a one-minute sampling rate over a period of almost 4 years. 
##    Different electrical quantities and some sub-metering values are available.
##
##    There are 9 variables in the dataset:
##
##    Date: Date in format dd/mm/yyyy
##
##    Time: time in format hh:mm:ss
##
##    Global_active_power: household global minute-averaged active power (in kilowatt)
##
##    Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
##
##    Voltage: minute-averaged voltage (in volt)
##
##    Global_intensity: household global minute-averaged current intensity (in ampere)
##
##    Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy).
##    It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave
##    (hot plates are not electric but gas powered).
##
##    Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy).
##    It corresponds to the laundry room, containing a washing-machine, a tumble-drier,
##    a refrigerator and a light.
##
##    Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy).
##    It corresponds to an electric water-heater and an air-conditioner.

plot1 <- function() {
        ## Read Electric power consumption data
        print("Reading Electric power consumption data (it could take a while)...")
        hc <-
                read.table(
                        "household_power_consumption.txt",
                        sep = ";",
                        header = TRUE,
                        na.strings = "?",
                        stringsAsFactors = FALSE
                )
        
        ## Subsetting data from the dates 2007-02-01 and 2007-02-02
        hc <- subset(hc, Date %in% c("1/2/2007", "2/2/2007"))
        
        ## Coersing numeric values for analysis
        hc$Global_active_power <- as.numeric(hc$Global_active_power)
        
        ## Plotting histogram with x-label and main title
        hist(
                hc$Global_active_power,
                main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)",
                col = "red"
        )
        
        ## Writing PNG-file
        dev.copy(png,'plot1.png', width = 480, height = 480, units = "px")
        dev.off()
        print("The histogram is saved in plot1.png")
}