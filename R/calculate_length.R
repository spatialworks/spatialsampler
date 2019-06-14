################################################################################
#
#' Calculate length (distance from east to west) of S3M grid given a value of
#' \code{d}
#'
#' @param d A numeric value for length (in kilometres) of the maximum distance
#'     of a village/community from a sampling point. This can be the output of
#'     the function \code{calculate_d()}
#'
#' @return A numeric value in kilometres of length (distance from east to west)
#'     of the S3M grid
#'
#' @examples
#'
#' # Calculate length given a d of 6 kms
#' calculate_length(d = 6)
#'
#' @source Based on equations by Mark Myatt
#'
#' @export
#'
#
################################################################################

calculate_length <- function(d) {
  length <- (3 * d) / 2
  return(length)
}
