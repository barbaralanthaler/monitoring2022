#This code is for ggplot2 based graphs

#Use the ggplot2 library:
library(ggplot2)

#Creation of a data frame (table) of ecological variables:

#We create two arrays:
virus <- c(10, 30, 40, 50, 60, 80)
death <- c(100, 240, 310, 470, 580, 690)

#The function to create the data frame:
data.frame(virus, death)

#We can assign the dataframe to an object:
d <- data.frame(virus, death)

#Summary of some objects (result is the univariate statistics of the table):
summary(d)

#To create a new ggplot we use the function ggplot(data, aesthetics(x=, y=)) + geometry we want to use (lines, point, ecc). In this case we use the function geom_point().
ggplot(d, aes(x=virus, y=death)) + geom_point()

#We can add information to geom_point()
ggplot(d, aes(x=virus, y=death)) + geom_point(size=3, col="red", pch=17)

#It is possible to use lines (the function connest observation in increasing order of x):
ggplot(d, aes(x=virus, y=death)) + geom_line()

#It is also possible to join different functions: 
ggplot(d, aes(x=virus, y=death)) + geom_point() + geom_line()

#Or polygons: 
ggplot(d, aes(x=virus, y=death)) + geom_polygon()

#We want to import data from outside R (the data is in the folder lab placed in my username), so to connects the csv file with R (set working directory):
setwd("/Users/barbara/lab/")

#To put the data inside R we use read.table(file, header = TRUE or FALSE (for default it is false. TRUE means if the names of the columns are present), sep (separating symbol).
#We assign the table to an object:
covid <- read.table("covid_agg.csv")

#R does not consider the names of the colums (they are considered as data), because header was FALSE (shorten the code T and F can be used):
covid <- read.table("covid_agg.csv", header = TRUE)

#Summary of the data:
summary(covid)

#We can use ggplot to make the plot os the points:
ggplot(covid, aes(x=lon, y=lat)) + geom_point(col="red")

#It is possible to change the size of points in respect to a specific variable
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point(col="red")


