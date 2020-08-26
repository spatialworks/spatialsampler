################################################################################
#
#' Function to calculate the number of hexagonal grids
#'
#' @param x A class SpatialPolygons or SpatialPolygonsDataFrame object defining
#'     the area to be sampled
#' @param d A numeric value for length (in kilometres) of the maximum distance
#'     of a village/community from a sampling point.
#' @param area A numeric value for area (in square kilometres) of a hexagon in a
#'     hexagonal grid defining the sampling spatial resolution
#' @param country Name of country where sampling area is located. This is used
#'     to determine the appropriate UTM projection to transform \code{x}
#'
#' @return A numeric value for number of hexagons to divide sampling area based
#'     on a specified \code{d} or a specified hexagon \code{area} size.
#'
#' @examples
#' # Calculate number of hexagons to create a sampling grid with a d = 10 kms
#' # on Sennar State in Sudan
#' sennar <- subset(sudan01, STATE == "Sennar")
#' calculate_n(x = sennar, d = 10, country = "Sudan")
#'
#' @export
#'
#
################################################################################

calculate_n <- function(x, d = NULL, area = NULL, country) {
  ## Check that d and area are not both specified
  if(!is.null(d) & !is.null(area)) {
    stop("Specify either d or area, not both. Try again.", call. = TRUE)
  }

  ## Check that either d or area are specified
  if(is.null(d) & is.null(area)) {
    stop("Specify either d or area. Try again.", call. = TRUE)
  }

  ## Get UTM coordinates for specified country
  utm.crs <- get_utm(lon = countryCentroid$lon[countryCentroid$country == country],
                     lat = countryCentroid$lat[countryCentroid$country == country])

  ## Convert x to appropriate UTM
  x.utm <- sp::spTransform(x = x, CRSobj = sp::CRS(utm.crs))

  ## If d is specified, calculate n
  if(!is.null(d)) {
    n <- ceiling(rgeos::gArea(x.utm) / (calculate_area(d = d)$hex * 1000000))
  }

  ## If area is specified, calculate n
  if(!is.null(area)) {
    n <- ceiling(rgeos::gArea(x.utm) / (area * 1000000))
  }

  ## Return output
  return(n)
}
