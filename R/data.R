################################################################################
#
#' A dataset of village names of Gedaref State, Sudan with data on coordinate locations
#'
#' @format A data frame with 5 columns and 625 rows:
#' \describe{
#' \item{\code{id}}{Unique identifier}
#' \item{\code{x}}{Longitude (in decimal format)}
#' \item{\code{y}}{Latitude (in decimal format)}
#' \item{\code{village}}{Village name}
#' \item{\code{locality}}{Locality name}
#' }
#' @source Sudan Bureau of Statistics and UNICEF Sudan
#'
#
################################################################################
"gedaref_villages"


################################################################################
#
#' A dataset of village names of Sennar State, Sudan with data on coordinate locations
#'
#' @format A data frame with 5 columns and 741 rows:
#' \describe{
#' \item{\code{id}}{Unique identifier}
#' \item{\code{x}}{Longitude (in decimal format)}
#' \item{\code{y}}{Latitude (in decimal format)}
#' \item{\code{village}}{Village name}
#' \item{\code{locality}}{Locality name}
#' }
#' @source Sudan Bureau of Statistics and UNICEF Sudan
#'
#
################################################################################
"sennar_villages"

################################################################################
#
#' A map dataset of class SpatialPolygonsDataFrame of level 1 administrative units (states) of Sudan
#'
#' @format A SpatialPolygonsDataFrame with 5 features with 4 fields:
#' \describe{
#' \item{\code{OBJECTID_1}}{Unique identifier}
#' \item{\code{STATE}}{State name}
#' \item{\code{Source}}{Source of data}
#' \item{\code{Region}}{Region name}
#' }
#' @source Sudan Bureau of Statistics and UNICEF Sudan
#'
#
################################################################################
"sudan01"

################################################################################
#
#' A map dataset of class SpatialPolygonsDataFrame of level 2 administrative units (localities) of Sudan
#'
#' @format A SpatialPolygonsDataFrame with 5 features and 5 rows:
#' \describe{
#' \item{\code{Locality}}{Locality name}
#' \item{\code{State}}{State name}
#' \item{\code{Source}}{Source of data}
#' \item{\code{Status}}{Status of verification}
#' \item{\code{season2013}}{Season 2013}
#' }
#' @source Sudan Bureau of Statistics and UNICEF Sudan
#'
#
################################################################################
"sudan02"

################################################################################
#
#' A dataset of UTM projections
#'
#' @format A data.frame with 12 rows and 3 columns:
#' \describe{
#' \item{\code{country}}{Name of country}
#' \item{\code{utm}}{UTM name}
#' \item{\code{proj}}{A character string specifying UTM projection}
#' }
#'
#
################################################################################
"map_projections"


################################################################################
#
#' A dataframe of country centroids
#'
#' @format A data.frame with 252 rows and 3 columns
#' \describe{
#' \item{\code{country}}{Name of country}
#' \item{\code{lon}}{Longitude coordinate of country centroid}
#' \item{\code{lat}}{Latitude coordinate of country centroid}
#' }
#'
#
################################################################################
"countryCentroid"

