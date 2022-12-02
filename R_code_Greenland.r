# R code on Greenland ice melting

# Libraries needed:
library(raster)
library(ggplot2)
library(RStoolbox)  #geom_raster function works just if this library is present
library(viridis)
library(patchwork)

# Set the woriking directory:
setwd("/Users/barbara/lab/") 

# Import the data:
# To import the data separately:
lst_2000 <- raster("lst_2000.tif")

# Exercise: plot lst_2000 with ggplot()
ggplot() +
geom_raster(lst_2000, mapping=aes(x=x, y=y, fill=lst_2000)) +         
scale_fill_viridis(option="mako")
# To reverse the legend (to focus on the ammount of ice -> ice melting is directoly correlated to temperature):
ggplot() +
geom_raster(lst_2000, mapping=aes(x=x, y=y, fill=lst_2000)) +         
scale_fill_viridis(option="mako", direction=-1)         # by default the direction is 1, to reverse it put -1
# To put a title:
ggplot() +
geom_raster(lst_2000, mapping=aes(x=x, y=y, fill=lst_2000)) +         
scale_fill_viridis(option="mako", direction=-1) +
ggtitle("Temperature 2000")
# Change the amount of transparency in the plot: alpha parameter (higher value = lower transparency)
ggplot() +
geom_raster(lst_2000, mapping=aes(x=x, y=y, fill=lst_2000)) +         
scale_fill_viridis(option="mako", alpha=0.8) +
ggtitle("Temperature 2000")

# Exercise: upload all the data
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010) 
plot(lst_2015)

# To import different data together: create a loop with lapply function (apply a function over a list or vector)
# list.files funtion: list the files in a directory/Folder
rlist <- list.files(pattern="lst")       # pattern = something in common in the files
rlist
# The lapply funtion can then be applied to the list:
import <- lapply(rlist, raster)
# To pass from 4 separate files to one single raster layer: stack function
TGr <- stack(import)    # This creates one single file with four layers inside
plot(TGr)

# Difference between 2000 and 2015:
p1 <- ggplot() +
geom_raster(TGr[[1]], mapping=aes(x=x, y=y, fill=lst_2000)) +         
scale_fill_viridis(option="mako", direction=-1, alpha=0.8) +
ggtitle("Temperature 2000")

p2 <- ggplot() +
geom_raster(TGr[[4]], mapping=aes(x=x, y=y, fill=lst_2015)) +         
scale_fill_viridis(option="mako", direction=-1, alpha=0.8) +
ggtitle("Temperature 2015")

p1 + p2

# Exercise: make the difference between 2015 and 2000
difft = TGr[[4]] - TGr [[1]]
p3 <- ggplot() +
geom_raster(difft, mapping=aes(x=x, y=y, fill=layer)) +         
scale_fill_viridis(option="inferno", alpha=0.8) +
ggtitle("Temperature difference between 2000 and 2015")

p1 + p2 + p3
