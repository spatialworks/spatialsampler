################################################################################
#
#' Function to calculate the area size of the resulting hexagon in a hexagonal
#' grid and the area size of the resulting triangle in a triangular grid for a
#' specified value of \code{d} (in kilometres) used in the simple spatial
#' sampling method (S3M).
#'
#' @param d A numeric value for length (in kilometres) of the maximum distance
#'     of a village/community from a sampling point.
#' @param digits A numeric value specifying the number of digits to round off
#'     the resulting area size. Default is NULL
#'
#' @return A data.frame of 1 row and 2 columns. First column is for the area
#'     (in square kilometres) for a triangle. Second column is for the area (in
#'     square kilometres) for a hexagon.
#'
#' @author Ernest Guevarra based on equations by Mark Myatt
#'
#' @examples
#' # Calculate the area of the triangle and hexagon for a d of 10 kilometres
#' calculate_area(d = 10, digits = 2)
#'
#' @export
#'
#
################################################################################

calculate_area <- function(d, digits = NULL) {
  #
  # Calculate triangular area
  #
  tri.area <- tan(30 * (pi / 180)) * (9 / 4) * d ^ 2
  #
  # Calculate hexagonal area
  #
  hex.area <- ((3 * sqrt(3)) / 2) * d ^ 2
  #
  # Concatenate calculations
  #
  area <- data.frame("tri" = tri.area, "hex" = hex.area)
  #
  # Round results if !is.null(digits)
  #
  if(!is.null(digits)) {
    round(area, digits = digits)
  }
  #
  # Return output
  #
  return(area)
}
