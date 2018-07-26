################################################################################
#
#' calculate_height
#'
#' Calculate height (distance from north to south) of S3M grid given a value of \code{d}
#'
#' @param d A numeric value for length (in kilometres) of the maximum distance
#'     of a village/community from a sampling point. This can be the output of
#'     the function \code{calculate_d()}
#'
#' @return A numeric value in kilometres of height (distance from north to south)
#'     of the S3M grid
#'
#' @examples
#'
#' # Calculate height given a d of 6 kms
#' calculate_height(d = 6)
#'
#' @source Based on equations by Mark Myatt
#'
#' @export
#'
#
################################################################################

calculate_height <- function(d) {
  height <- (sqrt(3) / 2) * d
  return(height)
}
