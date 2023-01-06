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
      
