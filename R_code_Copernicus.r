# How to download and analyse Copernicus data

# Copernicus set: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# Packages needed:
library(ncdf4)        #reading .nc files
library(raster)       # Geographic Data Analysis and Modeling
library(ggplot2)      # plots
library(RStoolbox)    # RS functions
library(viridis)      # legends - color gamut
library(patchwork)    # multiframe for ggplot

# Set the working direcotry:
setwd("/Users/barbara/lab/") 

# To import just one layer of the data: raster function (Create a RasterLayer object)
snow <- raster("c_gls_SCE_202012210000_NHEMI_VIIRS_V1.0.1.nc")
# To know the name of the layer recall the informations with "snow" and check "names"

# Exercise: plot the snow cover with ggplot and viridis
ggplot() +
geom_raster(snow, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent )) +         
scale_fill_viridis(option="mako")   
# The data is rough because of the resolution of the data dowloaded from Copernicus
# The gray area means there are no data in that part

# To use only European data we use coordinates: 
# Organize the extension of the coordinates (min x, max x, min y, max y)
ext <- c(-20, 70, 20, 75)
# Crop function: to crop on a specific area
snow_europe <- crop(snow, ext)
# Plot again:
ggplot() +
geom_raster(snow_europe, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent )) +         
scale_fill_viridis(option="mako")   

# Exercise: plot the two sets with the patchwor package
p1 <- ggplot() +
geom_raster(snow, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent )) +         
scale_fill_viridis(option="mako")   

p2 <- ggplot() +
geom_raster(snow_europe, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent )) +         
scale_fill_viridis(option="mako") 

p1 + p2 
