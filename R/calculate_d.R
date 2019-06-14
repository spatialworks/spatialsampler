################################################################################
#
#' Function to calculate the distance \code{d} given an area size (in square
#' kilometres) of a hexagon in a hexagonal spatial grid determining spatial
#' resolution of spatial sampling
#'
#' @param area Area (square kilometres) of a hexagon in a hexagonal grid.
#'     Determines the spatial resolution of the resulting spatial sample.
#' @param geom Spatial geometry to which \code{area} is specified for. Can be
#'     one of two options: \code{"tri"} for a triangle; \code{hex} for a
#'     hexagon.
#'
#' @return A numeric value for length (kilometres) of \code{d}
#'
#' @author Ernest Guevarra based on equations by Mark Myatt
#'
#' @examples
#' # Calculate d for a triangle with an area size of 130 square kilometres
#' calculate_d(area = 130, geom = "tri")
#'
#' # Calculate d for a hexagon with an area size of 260 square kilometres
#' calculate_d(area = 260, geom = "hex")
#'
#' @export
#'
#
################################################################################

calculate_d <- function(area, geom = c("tri", "hex")) {
  #
  # Check if geom more than 1 or is missing
  #
  if(length(geom) > 1 | is.null(geom) | missing(geom)) {
    stop("Polygon type needs to be specified. Try again,", call. = TRUE)
  }
  #
  # Check if geom is "tri"
  #
  if(geom == "tri") {
    d <- sqrt((area * 4) / (tan(30 * (pi/180)) * 9))
  }
  #
  # Check if geom is "hex"
  #
  if(geom == "hex") {
    d <- sqrt((area * 2) / (3 * sqrt(3)))
  }
  #
  # Return output
  #
  return(d)
}
