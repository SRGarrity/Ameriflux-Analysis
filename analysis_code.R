library(tidyverse)
library(ggplot2)
library(fpp)
library(readr)
library(lubridate)
library(anytime)
library(imputeTS)
library(shiny)
library(openair)

umbs <- read.csv('/Users/stevengarrity/ScratchProjects/Ameriflux-Analysis/AMF_US-UMB_BASE_HR_10-1.csv', skip = 2, header = TRUE)
str(umbs)
# adjust coding for NA values:
umbs <- replace(umbs, umbs == -9999, NA)
str(umbs)

# convert timestamp to something R-friendly:
umbs$timestamp <- parse_date_time2(as.character(umbs$TIMESTAMP_START), orders=c("Y!-m!-d! H!:M!"), tz="America/Detroit")

# start by looking at data from 2010-2014:
umbs14 <- umbs[umbs$TIMESTAMP_START>200812312300,]
dim(umbs14)

umbs14 %>% ggplot(aes(x=timestamp, y=NEE_PI)) +
  geom_line() +
  labs(x="", y=expression(paste("Net Ecosystem Exchange (", mu,"mol m"^"-2", "s"^"-1",")")))

# decompose time series:
dNEE <- ts(umbs14$NEE_PI, start = umbs14$timestamp[1], frequency=8760)
dNEE <- na.seadec(dNEE)
plot(stl(dNEE, s.window = "periodic", robust=TRUE, s.degree = 1))

# re-run on daily averages:
library(openair)
umbs14$date <- umbs14$timestamp # add "date" column so that the "timeAverage" function will work
umbs14daily <- timeAverage(umbs14, avg.time="day")
umbs14weekly <- timeAverage(umbs14, avg.time="week")
umbs14monthly <- timeAverage(umbs14, avg.time="month")
write_csv(umbs14daily, './decompose_flux/umbs_daily.csv')
write_csv(umbs14weekly, './decompose_flux/umbs_weekly.csv')
write_csv(umbs14monthly, './decompose_flux/umbs_monthly.csv')

dNEEdaily <- ts(umbs14daily$NEE_PI, start=c(2009,1), frequency=365)
dNEEdaily <- na.seadec(dNEEdaily)
plot(stl(dNEEdaily, s.window="periodic"),
     labels = c("NEE","Seasonal","Trend","Residual"), main="Daily Average")

dNEEweekly <- ts(umbs14weekly$NEE_PI, start=c(2009,1), frequency=52)
dNEEweekly <- na.seadec(dNEEweekly)
plot(stl(dNEEweekly, s.window="periodic"), 
     labels = c("NEE","Seasonal","Trend","Residual"), main="Weekly Average")

dNEEmonthly <- ts(umbs14monthly$NEE_PI, start=c(2009,1), frequency=12)
dNEEmonthly <- na.seadec(dNEEmonthly)
plot(stl(dNEEmonthly, s.window="periodic"), 
     labels = c("NEE","Seasonal","Trend","Residual"), main="Monthly Average")




