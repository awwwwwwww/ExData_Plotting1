## Title:       plot4.R
## Date:        20 August 2018
## Author:      Adam Weissman
## Description: Script to recreate Assignment's Plot 4
## Inputs:      None
## Returns:     None (but will save PNG to the working directory)

plot4<-function(){
    # load libraries
    library(readr)
    library(dplyr)
    library(lubridate)
    
    # Setup constants
    dlzip="XDAassignment1.zip"
    dlurl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    datafilename="household_power_consumption.txt"
    
    # Download data if it hasn't already been downloaded
    if(!file.exists(dlzip)){
        download.file(dlurl,dlzip)
        unzip(dlzip)
    } 
    
    # Read data in
    powerdata<-read_delim(datafilename,';')
    
    #change character string dates to lubridate type
    powerdata$Date<-dmy(powerdata$Date)
    
    #pull out just 1 Feb 2007 and 2 Feb 2007 data
    febData<-subset(powerdata,year(powerdata$Date)==2007&month(powerdata$Date)==2&(day(powerdata$Date)==1|day(powerdata$Date)==2))
    
    # set PNG device and set background to transparent instead of white
    png("plot4.png",bg=NA)
    
    # set plot area to be 2x2
    par(mfrow=c(2,2))    
    
    #make first plot
    with(febData,plot(ymd_hms(paste(Date,Time)),Global_active_power,type="l",xlab=NA,ylab="Global Active Power"))

    #make second plot
    with(febData,plot(ymd_hms(paste(Date,Time)),Voltage,type="l",xlab="datetime",ylab="Voltage"))

    
    #make the third plot...
    #start with an empty plot (type="n"), but with data to set axis height and length
    with(febData,plot(ymd_hms(paste(Date,Time)),Sub_metering_1,type="n",xlab=NA,ylab="Energy sub metering"))
    #add sub meter 1 data
    with(febData,points(ymd_hms(paste(Date,Time)),Sub_metering_1,type="l"))
    #add sub meter 2 data
    with(febData,points(ymd_hms(paste(Date,Time)),Sub_metering_2,type="l",col="red"))
    #add sub meter 3 data
    with(febData,points(ymd_hms(paste(Date,Time)),Sub_metering_3,type="l",col="blue"))
    #add legend
    legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,bty="n")
    
    #make fourth plot
    with(febData,plot(ymd_hms(paste(Date,Time)),Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
    
    # flush file stream
    dev.off()
    
}