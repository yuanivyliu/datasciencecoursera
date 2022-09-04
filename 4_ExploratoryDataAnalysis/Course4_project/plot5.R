#This file is for Course4 EDA Project - Question 5: 
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


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

#2.2 filter the NEI data by motor vehicle sources &  Baltimore City, fips == "24510"

motor_ems <- subset(NEI, SCC %in% motor_code)[, c("fips", "SCC", "Emissions", "year")]
motor_ems <- filter(motor_ems, motor_ems$fips == "24510")
    
motor_ems$year <- as.factor(motor_ems$year)
str(motor_ems$year)

motor_year_total <- motor_ems %>% 
    group_by(year) %>% 
    summarise(tot_ems = sum(Emissions))

#2.3 plot the data 

png(filename = "plot5_1.png")

g1 <- ggplot(motor_ems, aes(x = year, y = Emissions))
g1 + geom_boxplot() + 
    labs(x = "Year", y = "Total Emissions", 
         title = "Total PM2.5 emissions of motor vehicle in the Baltimore City from 1999-2008")

dev.off()#close the pdf device, then see the file.

png(filename = "plot5_2.png")

g2 <- ggplot(motor_year_total, aes(x = year, y = tot_ems))
g2 + geom_bar(stat = "identity", fill = "lightblue") + 
    labs(x = "Year", y = "Total Emissions", 
         title = "Total PM2.5 emissions of motor vehicle in the Baltimore City from 1999-2008")

dev.off()#close the pdf device, then see the file.
