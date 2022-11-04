# Comunity ecology example with R
# multivariate analysis

# We need the vegan package, a community ecology package
library(vegan)

# Set the working directory:
setwd("/Users/barbara/lab/")

# To upload the data (complete R project), we use the load function (relaods saved datasets):
load("biomes_multivar.RData")

# The ls function shows the files present in R
ls()

# To see the head of the biomes table:
head(biomes)
# The table contains 20 plots, impossible to represent

# Decorana: detrended correspondence analisys (same as the principal component analisys) to pass to a lower amount of axes
multivar <- decorana(biomes)

# To have information about the analisys done:
multivar
plot(multivar)
# Points that are near are related to each other

# To see the different biomes in the graph, it is possible to make a circle around the species belongin to the same biome:
attach(biomes_types)
# ordiellipse function: display Groups or Factor Levels in Ordination Diagrams 
# "type" indicates the column the biomes_types table
# "kind" is the type of ellipse
# "lwd" is the line width
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3)

# To lable the biomes we use the ordispider function:
ordispider(multivar, type, col=c("black","red","green","blue"), label=T)

# To export the data, we use the pdf function "name.pdf":
pdf("multivar.pdf")
# We have to put inside everything we want inside the pdf:
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label=T)
# To close the pdf:
dev.off()

# Exercise: export a pdf with only the multivar plot
pdf("secondoutput.pdf")
plot(multivar)
dev.off()
