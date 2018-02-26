################################################################################
#
# Function to assist in creating documentation for datasets in an R package
#
################################################################################

create_doc <- function(data,
                       name = deparse(substitute(data)),
                       description,
                       varList,
                       source = NULL) {

  sink("R/data.R", append = TRUE, type = "output")

  cat(" \n")
  cat(" \n")
  cat("################################################################################\n")
  cat("# \n")
  cat(paste("#' ", name, sep = ""), " \n")
  cat("#' \n")
  cat(paste("#' ", description, sep = ""), " \n")
  cat("#' \n")
  cat(paste("#' @format A data frame with ", ncol(data), " columns and ", nrow(data), " rows:", sep = ""), " \n")
  cat("#' \\describe{ \n")
  for(i in 1:length(names(data))) {
    cat(paste("#' \\item{\\code{", names(data)[i], "}}{", varList[i], "}", sep = ""), " \n")
  }
  cat("#' } \n")
  cat(paste("#' @source ", source, sep = ""), " \n")
  cat("#' \n")
  cat("# \n")
  cat("################################################################################ \n")
  cat(paste("\"", name, "\"", sep = ""))
  sink()
}


################################################################################
#
# Gedaref villages
#
################################################################################

varList <- c("Unique identifier",
             "Longitude (in decimal format)",
             "Latitude (in decimal format)",
             "Village name",
             "Locality name")

create_doc(data = gedaref_villages,
           name = "gedaref_villages",
           description = "A dataset of village names of Gedaref State, Sudan with data on coordinate locations",
           varList = varList,
           source = "Sudan Bureau of Statistics and UNICEF Sudan")

################################################################################
#
# Sennar villages
#
################################################################################

create_doc(data = sennar_villages,
           name = "sennar_villages",
           description = "A dataset of village names of Sennar State, Sudan with data on coordinate locations",
           varList = varList,
           source = "Sudan Bureau of Statistics and UNICEF Sudan")


################################################################################
#
# Sudan level 1 administrative map (States)
#
################################################################################

varList <- c("Unique identifier",
             "State name",
             "Source of data",
             "Region name")

create_doc(data = sudan01,
           name = "sudan01",
           description = "A map dataset of class SpatialPolygonsDataFrame of level 1 administrative units (states) of Sudan",
           varList = varList,
           source = "Sudan Bureau of Statistics and UNICEF Sudan")

################################################################################
#
# Sudan level 2 administrative map (Localities)
#
################################################################################

varList <- c("Locality name",
             "State name",
             "Source of data",
             "Status of verification",
             "Season 2013")

create_doc(data = sudan02,
           name = "sudan02",
           description = "A map dataset of class SpatialPolygonsDataFrame of level 2 administrative units (localities) of Sudan",
           varList = varList,
           source = "Sudan Bureau of Statistics and UNICEF Sudan")

################################################################################
#
# Turkey level 0 administrative map (National border)
#
################################################################################

varList <- c("Name (English)",
             "Administrative level 0 Code",
             "Length of Shape",
             "Area of Shape")

create_doc(data = turkey00,
           name = "turkey00",
           description = "A map dataset of class SpatialPolygonsDataFrame of level 0 administrative units (national) of Turkey",
           varList = varList,
           source = "General Command of Mapping of Turkey (\\url{http://www.hgk.msb.gov.tr/u-23-turkiye-mulki-idare-sinirlari.html})")


################################################################################
#
# Turkey level 1 administrative map (provinces)
#
################################################################################

varList <- c("Length of Shape",
             "Area of Shape",
             "Province name (English)",
             "Administrative level 0 Code",
             "Administrative level 1 Code",
             "Postal Code")

create_doc(data = turkey01,
           name = "turkey01",
           description = "A map dataset of class SpatialPolygonsDataFrame of level 1 administrative units (province) of Turkey",
           varList = varList,
           source = "General Command of Mapping of Turkey (\\url{http://www.hgk.msb.gov.tr/u-23-turkiye-mulki-idare-sinirlari.html})")


################################################################################
#
# Turkey level 2 administrative map (districts)
#
################################################################################

varList <- c("District Name (English)",
             "Province Name (English)",
             "Administrative level 0 Code",
             "Administrative level 1 Code",
             "Administrative level 2 Code",
             "Postal Code",
             "Length of Shape",
             "Additional Information",
             "Length of Shape",
             "Area of Shape")

create_doc(data = turkey02,
           name = "turkey02",
           description = "A map dataset of class SpatialPolygonsDataFrame of level 2 administrative units (district) of Turkey",
           varList = varList,
           source = "General Command of Mapping of Turkey (\\url{http://www.hgk.msb.gov.tr/u-23-turkiye-mulki-idare-sinirlari.html})")
