################################################################################
#
#' create_sp_grid
#'
#' Function to create sampling grids as per CSAS or S3M specifications. This is
#' a wrapper function for \code{spsample()} function in \code{sp} package that
#' adds arguments needed to implement CSAS and S3M-specific sampling.
#'
#' @param x Spatial object to grid
#' @param d A numeric value for distance (in kilometres) of the maximum distance
#'     of a village/community from a sampling point. Default is 10 kilometres.
#' @param area A numeric value for area (in square kilometres) of a hexagon in a
#'     hexagonal grid defining the sampling spatial resolution
#' @param country Name of country where sampling area is located. This is used
#'     to determine the appropriate UTM projection to transform \code{x}
#' @param buffer A numeric value for distance (in kilometres) to expand the
#'     borders of the given spatial object \code{x}. Specifying \code{buffer}
#'     corrects the behaviour of \code{spsample()} to limit selection of sampling
#'     points well within the borders of \code{x} often leaving areas at or near
#'     the border of \code{x} unsampled. Default is \code{d} (if specified)
#'     otherwise defaults to 0 (no buffer).
#' @param n Approximate number of sampling points / clusters needed. Approximate
#'     because \code{spsample()} does not always result in \code{n} grids. If
#'     \code{n} is the minimum number of sampling points required, specify
#'     \code{n.buffer} to inflate \code{n} with to ensure required minimum. If
#'     fixed \code{n} amount of sampling points needed, specify \code{fixed} to
#'     TRUE and specify \code{n.buffer} to inflate \code{n}.
#' @param n.factor Inflation factor for \code{n}. Default value is 0 (no inflation)
#'     which produces approximate number of grids (i.e., more or less \code{n}).
#'     If minimum number of sampling points required, specify \code{n.factor} to
#'     increase \code{n} with to ensure that number of grids will be at least
#'     \code{n}. If fixed number of sampling points required (i.e., exactly \code{n}),
#'     specify \code{n.factor} to increase \code{n} with. Function will go
#'     through repeat cycles of \code{spsample()} until \code{n} sampling
#'     points are selected.
#' @param type A character value of either "csas" or "s3m" to specify type of
#'     spatial sampling to perform. If \code{"csas"}, a systematically aligned
#'     sampling is applied by passing the argument \code{type} \code{"regular"}
#'     to \code{spsample}. If \code{"s3m"}, sampling on a hexagonal lattice is
#'     applied by passing the argument \code{type} \code{"hexagonal"} to
#'     \code{spsample}. Default is \code{"s3m"}.
#' @param fixed Logical. If TRUE, \code{n.factor} must be specified and function
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

create_sp_grid <- function(x, d = NULL, area = NULL, country = NULL,
                           buffer = ifelse(!is.null(d), d, 0),
                           n = NULL, n.factor = NULL,
                           type = "s3m",
                           fixed = FALSE) {
  #
  # Check that d and area are not both specified
  #
  if(!is.null(d) & !is.null(area)) {
    stop("Specify either d or area, not both. Try again.", call. = TRUE)
  }
  #
  # Check that d or area and n are not specified at the same time
  #
  if((!is.null(d) | !is.null(area)) & !is.null(n)) {
    stop("Specify either d or area or n only. Try again.", call. = TRUE)
  }
  #
  # Check that country is specified if d or area is specified
  #
  if((!is.null(d) | !is.null(area)) & is.null(country)) {
    stop("If d or area are specified, country needs to be specified. Try again", call. = TRUE)
  }
  #
  # If type is not "csas" or "s3m"
  #
  if(!type %in% c("csas", "s3m")) {
    stop("Unrecognised sampling type. Specify either 'csas' or 's3m'. Try again.", call. = TRUE)
  }
  #
  # Determine type based on spsample arguments
  #
  if(type == "csas") { type <- "regular" }
  if(type == "s3m") { type <- "hexagonal" }
  #
  # Create a sampling buffer
  #
  x <- create_buffer(x = x, buffer = buffer, country = country)
  #
  # Check if d specified and not n
  #
  if(!is.null(d) & is.null(n)) {
    #
    # Calculate n
    #
    n <- calculate_n(x = x, d = d, country = country)
  }
  #
  # Check if area specified and not n
  #
  if(!is.null(area) & is.null(n)) {
    #
    # Calculate n
    #
    n <- calculate_n(x = x, area = area, country = country)
  }
  #
  # Check if fixed == TRUE
  #
  if(fixed == TRUE) {
    #
    # Check if n.factor is specified
    #
    if(is.null(n.factor)) {
      #
      # Error message
      #
      stop("If fixed == TRUE, n.factor must be specified.")
    }
    #
    # Repeat spsample until n sampling points generated
    #
    repeat{
      #
      # Sample
      #
      spdf <- sp::spsample(x, n = n + n.factor, type = type)
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
