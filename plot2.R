#library(sqldf)   read.csv.sql() ??

#Change locale (name of days in english)
Sys.setlocale("LC_TIME", "English")

#Load sample for figure out classes
sampleData <- read.csv(unzip("exdata_data_household_power_consumption.zip"),
                       header = TRUE, nrows = 10, sep=";", na.string="?",
                       stringsAsFactors=FALSE)
classes <- sapply(sampleData, class)

#Load data
data_all <- read.csv(unzip("exdata_data_household_power_consumption.zip"), header = TRUE,
                     colClasses = classes, sep=";", na.string="?")
rm(sampleData)

#Subset interval
data <- subset(data_all, Date == "1/2/2007" | Date == "2/2/2007")
rm(data_all) #remove all data

#create new variable t
#NOTE: Cast as POSIXct  (POSIXlt can't be plot)
data$t<-as.POSIXct(strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))

attach(data)

png("plot2.png", bg="transparent", width=480, height=480)
plot(Global_active_power ~ t, data=data, type="l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
