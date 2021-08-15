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

##Plot 3##
plot(hhp_subset$Sub_metering_1~hhp_subset$dateTime, type="l",
    ylab="Global Active Power (kilowatts)", xlab="")
    lines(hhp_subset$Sub_metering_2~hhp_subset$dateTime,col='Red')
    lines(hhp_subset$Sub_metering_3~hhp_subset$dateTime,col='Blue')
#add legend to plot
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#create PNG copy and close
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()