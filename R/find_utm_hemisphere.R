################################################################################
#
#' Find UTM hemisphere based on a longitude and latitude GPS location.
#'
#' @param lat Latitude coordinate
#'
#' @return Either \code{north} or \code{south}
#'
#' @examples
#' #
#'
#' @export
#'
#
################################################################################

find_utm_hemisphere <- function(lat) {
  ifelse(lat > 0, "north", "south")
}
