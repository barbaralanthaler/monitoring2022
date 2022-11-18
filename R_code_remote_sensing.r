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

# Exercise: make a multiframe with the first 4 bands:
par(mfrow=c(2, 2))
plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)
plot(p224r63_2011[[3]], col=cl)
plot(p224r63_2011[[4]], col=cl)

# Execise: plot the different bands with a legend for each band
par(mfrow=c(2, 2))
clb <- colorRampPalette(c("darkblue", "cornflowerblue", "cyan"))(100)
plot(p224r63_2011[[1]], col=clb)
clg <- colorRampPalette(c("chartreuse4", "chartreuse", "darkolivegreen1"))(100)
plot(p224r63_2011[[2]], col=clg)
clr <- colorRampPalette(c("brown4", "brown2", "coral"))(100)
plot(p224r63_2011[[3]], col=clr)
clir <- colorRampPalette(c("deeppink", "darkorange", "yellow"))(100)
plot(p224r63_2011[[4]], col=clir)

# To mount bands all toghether with natural colours we use the plotRGB funtion (Red-Green-Blue plot of a multi-layered Raster object)
# We assign the single wavelenghts to the different components (ex. blue wavelenght to the blue component etc.)
# For every componten we specify which band we use (1, 2, 3, 4)
# To enhance the difference in the colours we use the parameter stretch (lin stands for linear)
# Remembrer to use dev.off() to not plot in the the previous created multiframe
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")

# In the near infreared there is the highest peak of reflectance of plants, so it should be used
# The plotRGB funciton can plot only 3 bands, so one has to be substitued
# For example, we remove the blue band:
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
# This makes everything that reflects in infrared red (it takes the colour of the component)
