# Species distribution modelling of the invasive species Solidago canadensis in Europe

# Packages needed
library(tidyverse) # prepare the data for analysis
library(spatstat) # point pattern analysis
library(rgdal) # geodata abstraction
library(raster) # data analysis and modelling
library(viridis) # colorblind friendly palettes for graphs
library(sf) # analyze spatial vector data
library(sdm) # species distribution modelling
library(dismo) # species distribution modelling

# Set the working directory
setwd("/Users/barbara/exam_monitoring/")

# First part ----

# The aim of the first part of the project is to analyze the spread in Europe of
# the invasive herbaceous species Solidago canadensis.
# In order to achieve this, occurrence data from the year 2000 and 2018 are used.

## Import the data ----
solidago <- read.csv2("0257762-220831081235567.csv", sep = "\t")

## Clean the data ----

# Filter the data
solidago <- solidago %>%
  filter(!is.na(decimalLongitude)) %>%  # only valid longitudes
  filter(!is.na(decimalLatitude)) %>%   # only valid latitudes
  filter(year == 2000 |
           year == 2018) %>%   # belonging to the years 2000 or 2018
  filter(basisOfRecord %in% c("HUMAN_OBSERVATION", "OBSERVATION"))  # only two types of records

# Filter columns: only the columns of the coordinates and the year of observation
# are relevant for this analysis
solidago_geo <- solidago %>%
  select(decimalLongitude, decimalLatitude, year)

# A column for the occurrences is added
solidago_geo$species <- 1

## Density maps ----

### Year 2000 ----

# Create a subset containing only the data of the year 2000
solidago_2000 <- solidago_geo %>%
  filter(year == 2000)

# Control whether the coordinates have the correct format
typeof(solidago_2000$decimalLongitude)
typeof(solidago_2000$decimalLatitude)

# Since they are both stored as characters, it is necessary to transform them
# into numerical values before using them
solidago_2000$decimalLongitude <-
  as.numeric(solidago_2000$decimalLongitude)
solidago_2000$decimalLatitude <-
  as.numeric(solidago_2000$decimalLatitude)

# Create a point pattern of the occurrences
solidago_planar_2000 <-
  ppp(x = solidago_2000$decimalLongitude,
      y = solidago_2000$decimalLatitude,
      c(-15, 40),
      c(35, 72))
# the vectors c(-15,40) and c(35,72) are used to use only data falling into the 
# longitudinal and latitudinal range of Europe

# Create the density plot of the occurrences
density_map_2000 <- density(solidago_planar_2000)

# Define the color palette: white represents minimum density, red maximum density
cl <- colorRampPalette(c("white", "yellow", "orange", "red"))(100)

# Plot the density map
plot(density_map_2000, col = cl, main = "Density map of the distribution of Solidago canadensis in 2000")
# Add the occurrence points
points(solidago_2000, pch = 20, cex = 0.5)
# Add the European coastlines
coastlines <-
  readOGR("ne_10m_coastline.shp") # Import the shapefile containing the coastlines
coastlines_europe <-
  crop(coastlines, extent(-15, 40, 35, 72)) # Crop only the European coastlines
# Plot the coastlines adding them to the density map
plot(coastlines_europe, add = TRUE)

### Year 2018 ----
# To have a comparison, the same procedure is now repeated with the data for
# the year 2018

# Create a subset containing only the data of the year 2018
solidago_2018 <- solidago_geo %>%
  filter(year == 2018)

# Convert the longitude and latitude into numeric values
solidago_2018$decimalLongitude <-
  as.numeric(solidago_2018$decimalLongitude)
solidago_2018$decimalLatitude <-
  as.numeric(solidago_2018$decimalLatitude)

# Create and plot the density map
solidago_planar_2018 <-
  ppp(x = solidago_2018$decimalLongitude,
      y = solidago_2018$decimalLatitude,
      c(-15, 40),
      c(35, 72))
density_map_2018 <- density(solidago_planar_2018)
plot(density_map_2018, col = cl, main = "Density map of the distribution of Solidago canadensis in 2018")
points(solidago_planar_2018, pch = 20, cex = 0.5)
# Add the European coastlines
plot(coastlines_europe, add = TRUE)

# Export the two graphs
pdf("density_maps.pdf")
plot(density_map_2000, col = cl, main = "Density map of the distribution of Solidago canadensis in 2000")
points(solidago_2000, pch = 20, cex = 0.5)
plot(coastlines_europe, add = TRUE)
plot(density_map_2018, col = cl, main = "Density map of the distribution of Solidago canadensis in 2018")
points(solidago_planar_2018, pch = 20, cex = 0.5)
plot(coastlines_europe, add = TRUE)
dev.off()

# Second part ----
# The aim of the second part is to analyze the variation in three of the 
# environmental variables that could favor the spread of the species

## Air temperature ----
# The data refer to the air temperature at 2 m above the land surface

### Year 2000 ----

# Import the data about the mean monthly global temperature in 2000
temp_2000 <-
  brick("CRU_mean_temperature_mon_0.5x0.5_global_2000_v4.03.nc")

# Use only European data
temp_europe_2000 <- crop(temp_2000, extent(-15, 40, 35, 72))

# Analyse the content of the file
temp_europe_2000 # It contains 12 layers, one for each month of the year

# Calculate the mean temperature
mean_temp_2000 <- mean(temp_europe_2000)

# Plot the mean temperature in Europe in 2000
plot(mean_temp_2000, col = inferno((255)), main = "Mean temperature Europe 2000")
plot(coastlines_europe, add = TRUE)

### Year 2018 ----

# The same procedure in now repeated to obtain the mean temperature in Europe in 2018

# Import the global data and crop only the European coordinates
temp_2018 <-
  brick("CRU_mean_temperature_mon_0.5x0.5_global_2018_v4.03.nc")
temp_europe_2018 <- crop(temp_2018, extent(-15, 40, 35, 72))
temp_europe_2018

# Calculate the mean
mean_temp_2018 <- mean(temp_europe_2018)

# Plot the data
plot(mean_temp_2018, col = inferno((255)), main = "Mean temperature Europe 2018")
plot(coastlines_europe, add = TRUE)

# To qualitatively assess the change in temperature the difference between 2018
# and 2000 is calculated and plotted
temp_diff <- mean_temp_2018 - mean_temp_2000
diff_temp <-
  colorRampPalette(c("lightblue", "white", "yellow", "darkorange", "firebrick4"))(100)
plot(temp_diff, col = diff_temp, main = "Temperature difference between 2018 and 2000")
plot(coastlines_europe, add = TRUE)

# Export the graphs
pdf("temperature.pdf")
plot(mean_temp_2000, col = inferno((255)), main = "Mean temperature Europe 2000")
plot(coastlines_europe, add = TRUE)
plot(mean_temp_2018, col = inferno((255)), main = "Mean temperature Europe 2018")
plot(coastlines_europe, add = TRUE)
plot(temp_diff, col = diff_temp, main = "Temperature difference between 2018 and 2000")
plot(coastlines_europe, add = TRUE)
dev.off()

## Soil moisture ----
# The data refer to the volume of water present in the first 7 cm of soil averaged
# over the year

# Import the data
moisture <-
  brick("volumetric-soil-water-layer-1_annual-mean_era5_1979-2018_v1.0.nc")

# Inspect the data
moisture
names(moisture) # It contains 40 different layers, one for every year from 1979 to 2018

# Use only European data
moisture_europe <- crop(moisture, extent(-15, 40, 30, 72))

### Year 2000 ----

# Use the layer of the year 2000
moisture_2000 <-
  subset(moisture_europe, grep("X2000", names(moisture_europe)))

# Set the color palette
cl_moisture <-
  colorRampPalette(
    c(
      "white",
      "red",
      "orange",
      "yellow",
      "aquamarine",
      "mediumturquoise",
      "aquamarine4"
    )
  )(100)

# Plot the mean soil moisture in Europe in 2000
plot(moisture_2000, col = cl_moisture, main = "Mean soil moisture Europe 2000")
plot(coastlines_europe, add = TRUE)

### Year 2018 ----

# Use the layer of the year 2018
moisture_2018 <-
  subset(moisture_europe, grep("X2018", names(moisture_europe)))

# Plot the mean soil moisture 2018
plot(moisture_2018, col = cl_moisture, main = "Mean soil moisture Europe 2018")
plot(coastlines_europe, add = TRUE)

# Calculate and plot the difference in mean soil moisture between 2018 and 2000
moisture_diff <- moisture_2018 - moisture_2000
diff_moisture <-
  colorRampPalette(c(
    "darkorange1",
    "orange",
    "yellow",
    "white",
    "blue",
    "blue3",
    "blue4"
  ))(100)
plot(moisture_diff, col = diff_moisture, main = "Soil moisture difference between 2018 and 2000")
plot(coastlines_europe, add = TRUE)

# Export the graphs
pdf("moisture.pdf")
plot(moisture_2000, col = cl_moisture, main = "Mean soil moisture Europe 2000")
plot(coastlines_europe, add = TRUE)
plot(moisture_2018, col = cl_moisture, main = "Mean soil moisture Europe 2018")
plot(coastlines_europe, add = TRUE)
plot(moisture_diff, col = diff_moisture, main = "Soil moisture difference between 2018 and 2000")
plot(coastlines_europe, add = TRUE)
dev.off()

## Precipitation ----
# The data refer to the daily sum of precipitation

### Year 2000 ----

# Import the data
rainfall_1995_2010 <-
  brick("rr_ens_mean_0.1deg_reg_1995-2010_v26.0e.nc")

# Inspect the data
rainfall_1995_2010
names(rainfall_1995_2010)
# The file contains the data about precipitation values recorded each day
# from 1995 to 2010

# Select only the data from 2000
rainfall_2000 <-
  subset(rainfall_1995_2010, grep("X2000", names(rainfall_1995_2010)))
# Check if the subset is correct
names(rainfall_2000)

# Calculate the mean
mean_rainfall_2000 <- mean(rainfall_2000)

# Use only European data
mean_rainfall_2000_europe <-
  crop(mean_rainfall_2000, extent(-15, 40, 30, 72))

# Define the color palette
cl_rainfall <-
  colorRampPalette(c(
    "darkorange",
    "darkolivegreen1",
    "darkolivegreen",
    "darkslategray"
  ))(100)

# Plot the mean precipitation in 2000
plot(mean_rainfall_2000_europe, main = "Mean rainfall Europe 2000", col = cl_rainfall)
plot(coastlines_europe, add = TRUE)

### Year 2018 ----

# Import and inspect the data
rainfall_2011_2022 <-
  brick("rr_ens_mean_0.1deg_reg_2011-2022_v26.0e.nc")
rainfall_2011_2022
names(rainfall_2011_2022)

# Filter data of 2018
rainfall_2018 <-
  subset(rainfall_2011_2022, grep("X2018", names(rainfall_2011_2022)))
names(rainfall_2018)

# Calculate the mean
mean_rainfall_2018 <- mean (rainfall_2018)

# Use only European data
mean_rainfall_2018_europe <-
  crop(mean_rainfall_2018, extent(-15, 40, 30, 72))
plot(mean_rainfall_2018_europe, main = "Mean rainfall Europe 2018", col = cl_rainfall)
plot(coastlines_europe, add = TRUE)

# Calculate and plot the difference in precipitation between 2018 and 2000
precipitation_diff <-
  mean_rainfall_2018_europe - mean_rainfall_2000_europe
diff_prec <-
  colorRampPalette(c(
    "orange",
    "yellow",
    "white",
    "lightblue",
    "cadetblue4",
    "blue",
    "darkblue"
  ))(100)
plot(precipitation_diff, col = diff_prec, main = "Difference in precipitation between 2018 and 2000")
plot(coastlines_europe, add = TRUE)

# Export the graphs
pdf("rainfall.pdf")
plot(mean_rainfall_2000_europe, main = "Mean rainfall Europe 2000", col = cl_rainfall)
plot(coastlines_europe, add = TRUE)
plot(mean_rainfall_2018_europe, main = "Mean rainfall Europe 2018", col = cl_rainfall)
plot(coastlines_europe, add = TRUE)
plot(precipitation_diff, col = diff_prec, main = "Difference in precipitation between 2018 and 2000")
plot(coastlines_europe, add = TRUE)
dev.off()

# Third part ----
# The third part of the project consists in creating a species distribution model 
# for the species in 2018
# The data used are the distribution of the species in 2018 and the three 
# environmental variables analysed in the second part

# The raster images of the predictors need the same resolution
# Change the resolution to the highest present (mean_rainfall_2018_europe)
res(mean_temp_2018)
res(moisture_2018)
res(mean_rainfall_2018_europe)
moisture_2018_resampled <-
  resample(moisture_2018, mean_rainfall_2018_europe, resample = "bilinear")
mean_temp_2018_resampled <-
  resample(mean_temp_2018, mean_rainfall_2018_europe, resample = "bilinear")

# Create a raster stack object with the environmental variables used as predictors
predictors <-
  stack(mean_temp_2018_resampled,
        moisture_2018_resampled,
        mean_rainfall_2018_europe)
names(predictors) <- c("temperature", "moisture", "rainfall")

# Create a data frame with the occurrence and predictors data
# Filter only coordinates
solidago_sdm <- solidago_2018 %>%
  select(decimalLongitude, decimalLatitude)
# Extract the points in which the species is present and the predictor values 
# for those points
presence <- raster::extract(predictors, solidago_sdm)
# Create "background values": points on the map in which the species is not
# present, for which the predictors are shown
background <- randomPoints(predictors, 20000)
absvals <- raster::extract(predictors, background)

# Create the dataframe
presence_background <-
  c(rep(1, nrow(presence)), rep(0, nrow(absvals)))
sdmdata <-
  data.frame(cbind(presence_background, rbind(presence, absvals)))

# Create the model
model <-
  glm(presence_background ~ temperature + moisture + rainfall, data = sdmdata)
prediction <- predict(predictors, model)

# Plot the model
plot(prediction, main = "Species distribution model for Solidago canadensis in 2018")
points(solidago_sdm, pch = 20, cex = 0.1)
plot(coastlines_europe, add = TRUE)

# Create pdf
pdf("sdm_solidago_canadensis.pdf")
plot(prediction, main = "Species distribution model for Solidago canadensis in 2018")
points(solidago_sdm, pch = 20, cex = 0.1)
plot(coastlines_europe, add = TRUE)
dev.off()

# Sources of the data:
# Species dataset: https://www.gbif.org/occurrence/search?taxon_key=5389029
# Shapefile of Europe: supplied by professor Rocchini
# Temperature: https://cds.climate.copernicus.eu/cdsapp#!/dataset/insitu-gridded-observations-global-and-regional?tab=form
# Soil moisture: https://cds.climate.copernicus.eu/cdsapp#!/dataset/sis-biodiversity-era5-global?tab=form
# Precipitation: https://surfobs.climate.copernicus.eu/dataaccess/access_eobs.php

# Other sources:
# Procedure for SDM: https://rspatial.org/raster/sdm/
