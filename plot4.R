###Reading, subsetting and manipulating the data###
###same across all four plot files###

##Optional##
#check working directory#
#getwd()
#set working directory if not already correct#
#setwd("C:/Working/Directory")

##Required##
#read data
hhp_full <- read.csv("exdata_data_household_power_consumption/household_power_consumption.txt",
                     header=T, sep=';', na.strings="?", nrows=2075259, check.names=F,
                     stringsAsFactors=F, comment.char="", quote='\"')

##Optional##
#check data
#head(hhp_full)
#names(hhp_full)
#dim(hhp_full)
#str(hhp_full)

##Required##
#subset data
hhp_subset <- subset(hhp_full, Date %in% c("1/2/2007","2/2/2007"))

#remove incomplete observation
#optional in this case as no incomplete obs
hhp_subset <- hhp_subset[complete.cases(hhp_subset),]

#format date
hhp_subset$Date <- as.Date(hhp_subset$Date, format="%d/%m/%Y")

#combine date and time column
dateTime <- paste(hhp_subset$Date,hhp_subset$Time)

#name combined column "dateTime"
dateTime <- setNames(dateTime, "DateTime")

#add "dateTime" to the subset
hhp_subset <- cbind(dateTime, hhp_subset)

#format "dateTime" as POSIXct
hhp_subset$dateTime <- as.POSIXct(dateTime)

##Optional##
#check subset
#head(hhp_subset)
#names(hhp_subset)
#dim(hhp_subset)
#str(hhp_subset)

###Plot 4##
#setup plot to window to contain four plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
#create all four plots using "with()" function
with(hhp_subset, {
    plot(Global_active_power~dateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~dateTime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~dateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~dateTime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
})
#create PNG copy and close
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
