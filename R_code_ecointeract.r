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

#to show the data in a table (the function invokes a data viewer) (ATTENTION: capital letter!):
View(meuse)

#Errore in View(meuse) : La dataentry X11 non può essere caricata
In aggiunta: Messaggi di avvertimento:
1: In system2("/usr/bin/otool", c("-L", shQuote(DSO)), stdout = TRUE) :
  il comando in esecuzione ''/usr/bin/otool' -L '/Library/Frameworks/R.framework/Resources/modules/R_de.so'' aveva status 1
2: In View(meuse) :
  non è possibile caricare un oggetto condiviso '/Library/Frameworks/R.framework/Resources/modules//R_de.so':
  dlopen(/Library/Frameworks/R.framework/Resources/modules//R_de.so, 0x0006): Library not loaded: /opt/X11/lib/libSM.6.dylib
  Referenced from: /Library/Frameworks/R.framework/Versions/4.2/Resources/modules/R_de.so
  Reason: tried: '/opt/X11/lib/libSM.6.dylib' (no such file), '/usr/local/lib/libSM.6.dylib' (no such file), '/usr/lib/libSM.6.dylib' (no such file)
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
