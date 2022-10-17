#Recall library:

library(sp)

data(meuse)

#The function coordinates set spatial coordinates to create a Spatial object, or retrieve spatial coordinates from a Spatial object (how the coordinates are set on the field)
coordinates(meuse) = ~ x+y

#Then we can plot meuse, which is now a spatial dataset (x and y are coordinates)
plot(meuse)

#Every single variable can be plotted in space. The funtion is spplot. The syntax is: spplot(dataset, "variable", main="Describing text"):
spplot(meuse, "zinc", main="Concentration of zinc")
