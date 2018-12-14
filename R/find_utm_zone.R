################################################################################
#
#' find_utm_zone
#'
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
  if (lat >= 72.0 & lat < 84.0 )
    if (lon >= 0.0 & lon <  9.0)
      return(31);
  if (lon >= 9.0 & lon < 21.0)
    return(33)
  if (lon >= 21.0 & lon < 33.0)
    return(35)
  if (lon >= 33.0 & lon < 42.0)
    return(37)

  (floor((lon + 180) / 6) %% 60) + 1
}
