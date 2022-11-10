# R code for remote sensing data analisys in ecosystem monitoring

# The packages needed are:
library(raster)
library(RStoolbox)

# Set the working directory:
setwd("/Users/barbara/lab/")

# brick function: creater a RasterBrick object (formed by different layers)
 p224r63_2011 <- brick("p224r63_2011_masked.grd")

# To show the differents bands: 
plot(p224r63_2011)
# Each band shows the reflectance of a different wavelength

# To change the color of the bands:
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(p224r63_2011, col=cl)

# The first band corresponds to the blue vawelength, if there is low reflectance the blue is completely absorbed
