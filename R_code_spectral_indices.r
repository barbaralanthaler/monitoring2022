# Calculate vegetation indices from remote sensing

library(raster)

# Upload the data
setwd("/Users/barbara/lab/") 
#Image from 1992
l1992 <- brick("defor1.png")
# Bands: 1 NIR, 2 red, 3 green
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
# Image from 2006
l2006 <- brick("defor2.png")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Create a multiframe
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Pure water completely absorbs the NIR (appears black), if there is soil it is a light colour

# Calculate the DVI of 1992:
dvi1992 <- l1992[[1]] - l1992[[2]]
cl <- colorRampPalette(c("darkblue","yellow","red","black"))(100)
plot(dvi1992, col=cl)
# Higher vegetation = higher value (red-black)

# DVI of 2006
dvi2006 <- l2006[[1]] - l2006[[2]]
cl <- colorRampPalette(c("darkblue","yellow","red","black"))(100)
plot(dvi2006, col=cl)
# Low vegetation = low color (darblue-yellow)

