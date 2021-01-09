################################################################################
#
#' Find the UTM zone based on a longitude and latitude GPS location.
#'
#' @param lon Longitude coordinate
#' @param lat Latitude coordinate
#'
#' @return Numeric value for UTM zone
#'
#' @examples
#' #
#'
#' @export
#'
#
################################################################################

find_utm_zone <- function(lon, lat) {
  if (lat > 55 & lat < 64 & lon > 2 & lon < 6) zone <- 32

  if (lat > 71 & lon >= 6 & lon < 9) zone <- 31

  if (lat > 71 & lon >= 9 & lon < 12) zone <- 33

  if (lat > 71 & lon >= 18 & lon < 21) zone <- 33

  if (lat > 71 & lon >= 21 & lon < 24) zone <- 35

  if (lat > 71 & lon >= 30 & lon < 33) zone <- 35

  zone <- (floor((lon + 180) / 6) %% 60) + 1

  return(zone)


  #if (lat >= 72.0 & lat < 84.0 )
  #  if (lon >= 0.0 & lon <  9.0)
  #    return(31);
  #if (lon >= 9.0 & lon < 21.0)
  #  return(33)
  #if (lon >= 21.0 & lon < 33.0)
  #  return(35)
  #if (lon >= 33.0 & lon < 42.0)
  #  return(37)

  #(floor((lon + 180) / 6) %% 60) + 1
}
