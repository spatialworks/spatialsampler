################################################################################
#
#' get_utm
#'
#' Get the appropriate UTM projection string given a longitude and latitude
#' coordinate reference system values.
#'
#' @param lon Longitude coordinate
#' @param lat Latitude coordinate
#' @param units UTM measurements units. Default is \code{m} for metres.
#'
#' @return A character string specifying the appropriate UTM projection
#'
#' @examples
#' #
#'
#' @export
#'
#
################################################################################

get_utm <- function(lon, lat, units = "m") {
  hemisphere <- find_utm_hemisphere(lat)
  zone <- find_utm_zone(lon, lat)
  paste("+proj=utm +zone=", zone, " +ellps=WGS84", " +", hemisphere, " +units=", units, sep = "")
}
