################################################################################
#
# Libraries
#
################################################################################

library(rgeos)
library(rgdal)
library(gstat)

################################################################################
#
# Sudan maps
#
################################################################################

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


################################################################################
#
# Turkey maps
#
################################################################################

turkey00 <- readOGR(dsn = "data-raw/tur_admn_adm012_pypl_generalcommandofmapping_hh_v3",
                    layer = "TUR_admn_adm0_py_GeneralCommandOfMapping_hh_v3",
                    verbose = FALSE)
turkey00 <- subset(turkey00, select = -NAME_TR)
devtools::use_data(turkey00, overwrite = TRUE)

turkey01 <- readOGR(dsn = "data-raw/tur_admn_adm012_pypl_generalcommandofmapping_hh_v3",
                    layer = "TUR_admn_adm1_py_GeneralCommandOfMapping_hh_v3",
                    verbose = FALSE)
turkey01 <- subset(turkey01, select = -NAME_TR)
devtools::use_data(turkey01, overwrite = TRUE)

turkey02 <- readOGR(dsn = "data-raw/tur_admn_adm012_pypl_generalcommandofmapping_hh_v3",
                    layer = "TUR_admn_adm2_py_GeneralCommandOfMapping_hh_v3",
                    verbose = FALSE)
turkey02 <- subset(turkey02, select = c(-NAME_TR, -PROV_TR))
devtools::use_data(turkey02, overwrite = TRUE)

