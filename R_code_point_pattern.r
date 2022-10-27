# Point patter analysy for population ecology

#Use of working direcotory (to recall the data from the lab folder):
setwd("/Users/barbara/lab/")

#Read the table
covid <- read.table("covid_agg.csv", header=TRUE)

#We need the spastat library
library(spatstat)
