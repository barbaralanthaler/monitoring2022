# Point pattern analysy for population ecology

#We need the spastat library
library(spatstat)

#Use of working direcotory (to recall the data from the lab folder):
setwd("/Users/barbara/lab/")

#Read the table
covid <- read.table("covid_agg.csv", header=TRUE)

#From point to a map, to see the density of the covid data. To make a planar point pattern:
#First attach the covid dataset to access the variables present in the data framework without calling the data frame.
#ppp(x=, y=, array(range of the x value), array(range of the y value)
attach(covid)
covid_planar <- ppp(x=lon, y=lat, c(-180,180), c(-90,90))

#Without attaching: covid_planar <- ppp(x=covid$lon, y=covid§lat, c(-180,180), c(-90,90))

#To create a density map of the points:
density_map <- density(covid_planar)

#To see the density map and the original points:
plot(density_map)
points(covid_planar, pch=19)

#To change the colors (color ramp is the legend), 100 is the amount colors used (tonalitá):
cl <- colorRampPalette(c("cyan","coral","chartreuse"))(100)
plot(density_map, col=cl)
points(covid_planar, pch=17, col="blue")

#Exercise: change the colors of the map (new name to not overwrite the old palette)
cln <- colorRampPalette(c("darkgoldenrod1", "deeppink", "darkslateblue", "coral"))(100)
plot(density_map, col=cl)
points(covid_planar, pch=8, col="darkblue")

#Use the rgdal package, the geogdata abstraction library:
library(rgdal)

#To upload the coastlines (read OGR vector maps into spatial objects):
coastlines <- readOGR("ne_10m_coastline.shp")

plot(covid_planar)

#To plot both the covid planar and the coastlines: 
plot(coastlines, add=T)

#To also add the density map: 
plot(density_map)
points(covid_planar, pch=19)
plot(coastlines, add=T, color="yellow")

#To change the color use colorRampPalette

#Now we create an abbundance data
#Marks are used to explain to the sofware where the data for abbundance is (cases is the variable we want to use):
marks(covid_planar) <- cases

#The function Smooth is used for the interpolation:
cases_map <- Smooth(covid_planar)

plot(cases_map)
points(covid_planar)
plot(coastlines, add=T)
