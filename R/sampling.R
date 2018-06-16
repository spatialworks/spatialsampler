################################################################################
#
#' create_sp_grid
#'
#' Function to create sampling grids as per CSAS or S3M specifications. This is
#' a wrapper function for \code{spsample()} function in \code{sp} package that
#' adds arguments needed to implement CSAS and S3M-specific sampling.
#'
#' @param x Spatial object to grid
#' @param n Approximate number of sampling points / clusters needed. Approximate
#'     because \code{spsample()} does not always result in \code{n} grids. If
#'     \code{n} is the minimum number of sampling points required, specify
#'     \code{n.buffer} to inflate \code{n} with to ensure required minimum. If
#'     fixed \code{n} amount of sampling points needed, specify \code{fixed} to
#'     TRUE and specify \code{n.buffer} to inflate \code{n}.
#' @param n.buffer Inflation factor for \code{n}. Default value is 0 (no inflation)
#'     which produces approximate number of grids (i.e., more or less \code{n}).
#'     If minimum number of sampling points required, specify \code{n.buffer} to
#'     increase \code{n} with to ensure that number of grids will be at least
#'     \code{n}. If fixed number of sampling points required (i.e., exactly \code{n}),
#'     specify \code{n.buffer} to increase \code{n} with. Function will go
#'     through repeat cycles of \code{spsample()} until \code{n} sampling
#'     points are selected.
#' @param type A character value of type of spatial sampling to perform. Can be
#'     one of seven options: 1) \code{"random"} - completely spatial random;
#'     2) \code{"regular"} - systematically aligned sampling (CSAS);
#'     3) \code{"stratified"} - stratified random (ESAS); 4) \code{"non-aligned"} -
#'     non-aligned systematic sampling; 5) \code{"hexagonal"} - sampling on a
#'     hexagonal lattice (S3M); 6) \code{"clustered"} - clustered sampling; and,
#'     7) \code{"Fibonacci"} - Fibonacci sampling on the sphere.
#' @param fixed Logical. If TRUE, \code{n.buffer} must be specified and function
#'     will go through repeat cycles of \code{spsample()} until \code{n}
#'     sampling points are selected. Default is FALSE.
#' @return An object of SpatialPoints-class. The number of points is only
#'     guaranteed to equal \code{n} when sampling is done in a square box,
#'     i.e. (sample.Spatial). Otherwise, the obtained number of points will have
#'     expected value \code{n}.
#' @examples
#' #
#'
#' @export
#'
#'
#
################################################################################

create_sp_grid <- function(x, n, n.buffer = 0,
                           type, fixed = FALSE) {
  #
  # Check if fixed == TRUE
  #
  if(fixed == TRUE) {
    #
    # Check if n.buffer is specified
    #
    if(n.buffer == 0) {
      #
      # Error message
      #
      stop("If fixed == TRUE, n.buffer must be greater than 0.")
    }
    #
    # Repeat spsample until n sampling points generated
    #
    repeat{
      #
      # Sample
      #
      spdf <- sp::spsample(x, n = n + n.buffer, type = type)
      #
      #
      #
      if(length(spdf) == n) break
    }
  } else {
    #
    # Sample
    #
    spdf <- sp::spsample(x, n = n, type = type)
  }
  #
  #
  #
  return(spdf)
}
