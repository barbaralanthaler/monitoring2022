# R code for remote sensing data analisys in ecosystem monitoring

# The package needed is:
library(raster)

# Set the working directory:
setwd("/Users/barbara/lab/")

# brick function: creates a RasterBrick object (formed by different layers)
 p224r63_2011 <- brick("p224r63_2011_masked.grd")

# To show the differents bands: 
plot(p224r63_2011)
# Each band shows the reflectance of a different wavelength

# To change the color of the bands:
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(p224r63_2011, col=cl)
# The first band corresponds to the blue vawelength, if there is low reflectance the blue is completely absorbed

# To only plot the blue spectrum reflectance band (B1_sre):
 # solution 1:
plot(p224r63_2011$B1_sre, col=cl)
 # solution 2:
plot(p224r63_2011[[1]], col=cl)

# Exercise: change the color ramp palette with colors from darkblue to lightblue
clb <- colorRampPalette(c("darkblue", "cornflowerblue", "cyan"))(100)
plot(p224r63_2011$B1_sre, col=clb)

# How to build a multiframe (more images together):
# Use the par function (mf stands for multiframe). 1 row, 2 colums -> two images one near the other
par(mfrow=c(1, 2))
plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)

# Exercise: make a multiframe with the first 4 bands
par(mfrow=c(2, 2))
plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)
plot(p224r63_2011[[3]], col=cl)
plot(p224r63_2011[[4]], col=cl)

