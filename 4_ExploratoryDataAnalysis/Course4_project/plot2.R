#This file is for Course4 EDA Project - Question 2: 
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? 

#Use the base plotting system to make a plot answering this question. 

#1. loading the data (make sure each of those files is in your current working directory )
library(lubridate)
library(RColorBrewer)

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
ems_mrld <- subset(NEI, fips == "24510")
head(ems_mrld)


#2.2 calculate the total emissions based on each year
total_ems <- with(ems_mrld, tapply(Emissions, year, sum))
total_ems_mrld <- data.frame(year = names(total_ems), emissions = total_ems)

total_ems_mrld$year <- as.Date(total_ems_mrld$year, "%Y-%m-%d")
class(total_ems_mrld$year)

png(filename = "plot2.png")

with(total_ems_mrld, barplot(emissions, names.arg = c("1999", "2002", "2005", "2008"),
                             col = "light blue",
                             xlab = "Year", ylab = "Total Emissions",
                          main = "Total PM2.5 emissions in the  Baltimore City from 1999 to 2008"))

dev.off()#close the pdf device, then see the file.

