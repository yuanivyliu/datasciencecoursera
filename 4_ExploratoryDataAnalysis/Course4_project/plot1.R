#This file is for Course4 EDA Project - Question 1: 
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#1. loading the data (make sure each of those files is in your current working directory )

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

#2. Plotting year-total emissions
png(filename = "plot1.png")
total_ems <- tapply(NEI$Emissions, NEI$year, sum)
rng <- range(total_ems, na.rm = TRUE)
with(NEI, plot(unique(year), total_ems, pch = 19, xlab = "Year", ylab = "Total Emissions",
               main = "Total emissions from PM2.5 in the U.S. from 1999 to 2008", ylim = rng))

dev.off()#close the pdf device, then see the file.

