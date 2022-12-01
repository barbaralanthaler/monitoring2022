# How to download and analyse Copernicus data

# Copernicus set: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# Packages needed:
library(ncdf4)        #reading .nc files
library(raster)       # Geographic Data Analysis and Modeling
library(ggplot2)      # plots
library(RStoolbox)    # RS functions
library(viridis)      # legends - color gamut
library(patchwork)    # multiframe for ggplot

# setwd("/Users/barbara/lab/") 

# To import just one layer of the data: raster function (Create a RasterLayer object)
