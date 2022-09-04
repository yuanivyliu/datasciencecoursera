#This file is for Course4 EDA Project - Question 6: 
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?


#1. loading the data (make sure each of those files is in your current working directory )
library(lubridate)
library(RColorBrewer)
library(ggplot2)
library(dplyr)
library(stringr)

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/PM2.5.zip", mode = 'wb')
unzip("PM2.5.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
str(SCC)


#2. Plotting year-total emissions in the U.S. from motor vehicle sources

#2.1 find the motor vehicle sources code in SCC

motor <- SCC[grep("Motor|Vehicle|motor|vehicle", SCC$SCC.Level.Two), ]
View(motor)

motor_code <- motor$SCC 

#2.2 filter the NEI data by motor vehicle sources &  Baltimore/Los Angeles City

motor_ems <- subset(NEI, SCC %in% motor_code)[, c("fips", "SCC", "Emissions", "year")]

motor_ems$year <- as.factor(motor_ems$year)
str(motor_ems$year)

motor_ems_bt <- filter(motor_ems, motor_ems$fips == "24510")
motor_ems_la <- filter(motor_ems, motor_ems$fips == "06037")

mrg <- rbind(motor_ems_bt, motor_ems_la)

total <- mrg %>% 
    group_by(fips, year) %>% 
    summarise(tot_ems = sum(Emissions))

#2.3 plot the data 
png(filename = "plot6.png")

g <- ggplot(total, aes(x = year, y = tot_ems, fill = fips))
g + geom_bar(stat = "identity", position = "dodge") +
    labs(x = "Year", y = "Total Emissions", 
         title = "Total PM2.5 emissions in the  Baltimore and LA City from 1999 to 2008")+
    scale_fill_brewer(palette = "Pastel1") + 
    scale_fill_discrete(name = "City",
                        breaks = c("06037", "24510"),
                        labels = c("Los Angeles", "Baltimore"))
   
dev.off()#close the pdf device, then see the file.
