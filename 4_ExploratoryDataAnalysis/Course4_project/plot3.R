#This file is for Course4 EDA Project - Question 3: 
#Of the four types of sources indicated by the (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008?

#Use the ggplot2 plotting system to make a plot answer this question. 

#1. loading the data (make sure each of those files is in your current working directory )
library(lubridate)
library(RColorBrewer)
library(ggplot2)
library(dplyr)

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/PM2.5.zip", mode = 'wb')
unzip("PM2.5.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
summary(NEI)
str(SCC)

#2. Plotting year-total emissions in the Baltimore City, Maryland(fips == "24510")
#2.1 subtract the Baltimore City data
ems_bltm <- subset(NEI, fips == "24510")
head(ems_bltm)
str(ems_bltm)

#2.2 calculate the total emissions based on each year

ems_bltm$year <- as.Date(paste(ems_bltm$year, 1, 1, sep = "-"), format = "%Y-%m-%d")
tot_ems_bltm <- ems_bltm %>% 
    select(Emissions, type, year) %>% 
    group_by(type, year) %>% 
    summarise(total_ems = sum(Emissions))

#2.3 plot the total emissions in the Baltimore City based on type

png(filename = "plot3.png")

g <- ggplot(tot_ems_bltm, aes(x = year, y = total_ems, fill = type))
g + geom_bar(stat = "identity", position = "dodge") +
    labs(x = "Year", y = "Total Emissions", 
         title = "Total PM2.5 emissions in the  Baltimore City from 1999 to 2008")+
    scale_fill_brewer(palette = "YlGnBu") + 
    scale_x_date(date_breaks = "3 years", date_labels = c("2008", "1999", "2002", "2005"))
    
dev.off()#close the pdf device, then see the file.   
