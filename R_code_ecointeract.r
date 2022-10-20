# This is a code for investigating relationships among ecological variables

# We are using the sp package. To install it use ("" are used to install additional packages that are external of R):
#install.packages("sp")

# To recall the package:
library(sp)
# or: require(sp)

#meuse is the dataset from Northern Europe present in sp (https://cran.r-project.org/web/packages/gstat/vignettes/gstat.pdf)
# To use the data available inside the package (the function recalls data sets): 
data(meuse)
#inside the () the arguments are put. An argument is a descripiton of the function.

#To show the data in a table (the function invokes a data viewer) (ATTENTION: capital letter!):
View(meuse)

#To return only the first part of an object: 
head(meuse)

#To show only the column names:
names(meuse)

#To do a summary of the dataset:
summary(meuse)

#To plot one variable in respect to another: plot(cadmium,zinc)
#this gives an error. cadmium and zinc have to linked to meuse before ($ is used to link things):
plot(meuse$cadmium, meuse$zinc)

#assign to create new objects to plot in a more simple way:
cad <- meuse$cadmium
zin <- meuse$zinc
plot(cad,zin)

#Only with dataframes (tables): attach set of R objects to a search path.
attach(meuse)
#it is then possible to use directly the two columns for the plot (in this case $ is not needed):
plot(cadmium, zinc)
#it is also possible to detach with detach(meuse)

#To produce scatterplot matrices (also possible to change the color with the argument col="")
pairs(meuse)

#To change the color of the graph, colors are stored inside are with "": 
plot(cadmium, zinc, col="coral")

#To increase the size of the point (to mantain the color we keep the col argument): 
plot(cadmium, zinc, col="coral", cex=2)

#To change the type of symbol we use the argument pch

#To plot only a few variables (pair plots them all), we want to solect only a few columns, in this case from column 3 to columns 6:

# First way: option 5 and option 6 for the squared brackets)
#The , shows the starting point:
meuse[,3:6]

#To name the subset:
pol <- meuse[,3:6]

#To show only the head of pol:
head(pol)

#Now instead of paining all the dataset, only the pol data can be plotted:
pairs(pol, col="blue", cex=1.5)

#Second way: use the names of the column (~ is mande with option N):
pairs(~ cadmium + copper + lead + zinc, data=meuse)


#The function coordinates set spatial coordinates to create a Spatial object, or retrieve spatial coordinates from a Spatial object (how the coordinates are set on the field)
coordinates(meuse) = ~ x+y

#Then we can plot meuse, which is now a spatial dataset (x and y are coordinates)
plot(meuse)

#Every single variable can be plotted in space. The funtion is spplot. The syntax is: spplot(dataset, "variable", main="Describing text"):
spplot(meuse, "zinc", main="Concentration of zinc")

#To make a spatial plot of several variables (c is an array):
spplot(meuse, c("copper","zinc"))

#Instead of using different colours for the values we can use bubbles (the size increases according to the increase of the varible's value:
bubble(meuse, "zinc", main="Concentration of zinc")
