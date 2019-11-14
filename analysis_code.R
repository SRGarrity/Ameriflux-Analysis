library(tidyverse)
library(ggplot2)
library(fpp)
library(readr)

umbs <- read.csv('/Users/stevengarrity/ScratchProjects/Ameriflux-Analysis/AMF_US-UMB_BASE_HR_10-1.csv', skip = 2, header = TRUE)
str(umbs)

umbs <- replace(umbs, umbs == -9999, NA)

plot(umbs$NEE_PI)
plot(umbs$FC)