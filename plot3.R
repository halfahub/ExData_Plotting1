##    Description: Measurements of electric power consumption in one household with 
##    a one-minute sampling rate over a period of almost 4 years. 
##    Different electrical quantities and some sub-metering values are available.
##
##    There are 9 variables in the dataset:
##
##    Date: Date in format dd/mm/yyyy
##
##    Time: time in format hh:mm:ss.
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

plot3 <- function() {
        ## Read Electric power consumption data
        print("Reading Electric power consumption data (it could take a while)...")
        hc <-
                read.table(
                        "household_power_consumption.txt",
                        sep = ";",
                        header = TRUE,
                        stringsAsFactors = FALSE,
                        colClasses = c("character", "character", 
                                       "numeric","numeric",
                                       "numeric","numeric",  
                                       "numeric","numeric","numeric"),
                        #skip=66636,
                        #nrow = 66636+2880,
                        na.strings = "?"
                )
        
        ## Subsetting data from the dates 2007-02-01 and 2007-02-02
        hc <- subset(hc, Date %in% c("1/2/2007", "2/2/2007"))
        
        ## Plotting diagram with y-label and x-axis labels
        with(hc, {
                ## Constructing datetime variable for the x-axis
                time <- as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")
                
                ## XY-plot Sub_metering_1 without the x-axis labels
                plot(time,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",xaxt='n')
                
                ## Add XY-plots for Sub_metering 2 and 3
                points(time,Sub_metering_2,type="l",col="red")
                points(time,Sub_metering_3,type="l",col="blue")
                
                ## Round x-axis values by days 
                r <- as.POSIXct(round(range(time), "days"))
                
                ## Plotting x-axis labels
                axis.POSIXct(1, at = seq(r[1], r[2], by = "day"), format = "%a")
                
                ## Add a legend
                legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
        })
        
        ## Writing PNG-file
        dev.copy(png,'plot3.png', width = 480, height = 480, units = "px")
        dev.off()
        print("The diagram is saved in plot3.png")
}