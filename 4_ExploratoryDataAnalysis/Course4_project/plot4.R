#This file is for Course4 EDA Project - Question 4: 
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?


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


#2. Plotting year-total emissions in the U.S. from coal combustion-related sources

#2.1 find the coal combustion-related sources code in SCC

SCC$SCC.Level.Four <- as.character(SCC$SCC.Level.Four)
class(SCC$SCC.Level.Four)

coal <- SCC[grep("Coal", SCC$SCC.Level.Four), ]
coal_code <- coal$SCC 

#2.2 filter the NEI data by coal combustion-related sources
coal_ems <- subset(NEI, SCC %in% coal_code)[, c("SCC", "Emissions", "year")]
coal_ems$year <- as.factor(coal_ems$year)
str(coal_ems$year)

coal_year_total <- coal_ems %>% 
    group_by(year) %>% 
    summarise(tot_ems = sum(Emissions))


#2.3 plot the data 

png(filename = "plot4_1.png")
g1 <- ggplot(coal_ems, aes(x = year, y = Emissions))
g1 + geom_boxplot() + labs(x = "Year", y = "Total Emissions", 
                          title = "Total PM2.5 emissions of coal combustion-related from 1999-2008")
dev.off()#close the pdf device, then see the file.


png(filename = "plot4_2.png")
g2 <- ggplot(coal_year_total, aes(x = year, y = tot_ems))
g2 + geom_bar(stat = "identity", fill = "lightblue") + 
    labs(x = "Year", y = "Total Emissions", 
         title = "Total PM2.5 emissions of coal combustion-related from 1999-2008")
    

dev.off()#close the pdf device, then see the file.
