## Title:       plot2.R
## Date:        20 August 2018
## Author:      Adam Weissman
## Description: Script to recreate Assignment's Plot 2
## Inputs:      None
## Returns:     None (but will save PNG to the working directory)

plot2<-function(){
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
    png("plot2.png",bg=NA)
    
    #make the plot
    with(febData,plot(ymd_hms(paste(Date,Time)),Global_active_power,type="l",xlab=NA,ylab="Global Active Power (kilowatts)"))
    
    # flush file stream
    dev.off()
    
}