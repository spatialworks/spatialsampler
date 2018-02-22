################################################################################
#
# Libraries
#
################################################################################

library(rgeos)
library(rgdal)
library(gstat)

sudan01 <- readOGR(dsn = "data-raw/Boundary_Shapefiles",
                   layer = "02_StateBoundaries_Poly_2013",
                   verbose = FALSE)
devtools::use_data(sudan01, overwrite = TRUE)


sudan02 <- readOGR(dsn = "data-raw/Boundary_Shapefiles",
                   layer = "03_Locality_Boundaries_Poly_2013",
                   verbose = FALSE)
devtools::use_data(sudan02, overwrite = TRUE)


sennar_villages <- read.table(file = "data-raw/SN.csv",
                              header = TRUE,
                              sep = ",")
devtools::use_data(sennar_villages, overwrite = TRUE)


gedaref_villages <- read.table(file = "data-raw/GD.csv",
                              header = TRUE,
                              sep = ",")
devtools::use_data(gedaref_villages, overwrite = TRUE)

