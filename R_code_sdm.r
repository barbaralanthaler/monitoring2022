# R code for species distribution modelling

# packages needed:
library(sdm) # package for species distribution modelling
library(raster) # reading, writing, manipulating, analyzing and modeling of spatial data
library(rgdal) # provides bindings to the 'Geospatial' Data Abstraction Library 

file <- system.file("external/species.shp", package="sdm") 
  # the system.file function finds the full file names of files in packages etc.
 species <- shapefile(file)
  # the shapefile function reads or writes a shapefile
    #shapefile: simple, nontopological format for storing the geometric location and attribute information of geographic features. 
      #Geographic features in a shapefile can be represented by points, lines, or polygons (areas).
      
# looking at the set
species
#plot
plot(species)

# looking at the occurrences
species$Occurrence

# plotting the occuruncece (1) and non occurrence (0)
plot(species[species$Occurrence == 1,],col='blue',pch=16)
  # to add the non occurrence (0) use points function: adds point to a plot
points(species[species$Occurrence == 0,],col='red',pch=16)

# predictors: look at the path
path <- system.file("external", package="sdm")
# list the predictors
lst <- list.files(path=path, pattern='asc$', full.names = T)
  # the list.files function produces a character vector of the names of files or directories in the named directory
    # path: a character vector of full path names; the default corresponds to the working directory.
    # pattern: an optional regular expression. Only file names which match the regular expression will be returned
    # full.names: a logical value. If TRUE, the directory path is prepended to the file names to give a relative file path. If FALSE, the file names (rather than paths) are returned.
lst
  #[1] "/Library/Frameworks/R.framework/Versions/4.2/Resources/library/sdm/external/elevation.asc"    
  #[2] "/Library/Frameworks/R.framework/Versions/4.2/Resources/library/sdm/external/precipitation.asc"
  #[3] "/Library/Frameworks/R.framework/Versions/4.2/Resources/library/sdm/external/temperature.asc"  
  #[4] "/Library/Frameworks/R.framework/Versions/4.2/Resources/library/sdm/external/vegetation.asc"   

# Create a RasterStack object
preds <- stack(lst)
  # A RasterStack is a collection of RasterLayer objects with the same spatial extent and resolution. 

# Plot preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# Plot the different predictors and occurences
# Elevation
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# Temperature
plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# Precipitation
plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# Vegetation
plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# Create the species distribution model
  # set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)
  # sdmData function: Creates a sdmdata objects that holds species (single or multiple) and explanatory variates.
  # In addition, more information such as spatial coordinates, time, grouping variables, and metadata (e.g., author, date, reference, etc.) can be included.
    # train: Training data containing species observations as a data.frame or SpatialPoints or SpatialPointsDataFrames.
    # predictors: Explanatory variables (predictors), defined as a raster object.
# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
  # sdm function: Fit and evaluate species distribution models.
    # data: a sdmdata object created using sdmData function
    # methods: Character. Specifies the methods, used to fit the models.
# make the raster output layer
p1 <- predict(m1, newdata=preds)
  # predict function: make a Raster or matrix object (depending on input dataset) with predictions from one or several fitted models in sdmModels object.

# plot the output
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)

# Change the names in the plot of the stack:
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
