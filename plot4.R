power <- read.table('household_power_consumption.txt', skip = 1, sep= ';')
names(power) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power','Voltage',
                  'Global_intensity', 'Sub_metering_1','Sub_metering_2','Sub_metering_3')
subpower <- subset(power,power$Date == '1/2/2007' | power$Date == '2/2/2007')

subpower$Date <- as.Date(subpower$Date, format = '%d/%m/%Y')
subpower$Time <- strptime(subpower$Time, format = '%H:%M:%S')
subpower[1:1440, 'Time'] <- format(subpower[1:1440,'Time'],'2007-02-01 %H:%M:%S') 
subpower[1441:2880, 'Time'] <- format(subpower[1441:2880,'Time'], '2007-02-02 %H:%M:%S')

par(mfcol=c(2,2))

global_active_power <- as.numeric(subpower$Global_active_power)
plot(subpower$Time, global_active_power, type='l',xlab='',
     ylab='Global Active Power (kilowatts)')

sub_metering_1 <- as.numeric(subpower$Sub_metering_1)
sub_metering_2 <- as.numeric(subpower$Sub_metering_2)
sub_metering_3 <- as.numeric(subpower$Sub_metering_3)
with(subpower, plot(Time,sub_metering_1,type='n',xlab='',ylab='Energy sub metering'))
with(subpower,lines(Time,sub_metering_1))
with(subpower,lines(Time,sub_metering_2,col ='red'))
with(subpower,lines(Time,sub_metering_3,col='blue'))
legend('topright',lty=1,col=c('black','red','blue'),legend=c('Sub_metering_1','Sub_metering_2',
                                                             'Sub_metering_3'),cex=0.6)

voltage <- as.numeric(subpower$Voltage)
plot(subpower$Time, voltage, type='l',xlab='datetime', ylab='Voltage')

global_reactive_power <- as.numeric(subpower$Global_reactive_power)
plot(subpower$Time, global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power')

dev.copy(png,file='plot4.png')
dev.off()
