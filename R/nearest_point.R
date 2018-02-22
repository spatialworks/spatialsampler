################################################################################
#
#' get_nearest_point
#'
#' Function to select nearest community to a given sampling location
#'
#' @param data An input data frame of village/community locations with at least
#'     information on longitude and latitude coordinates. This argument is
#'     optional. If provided, must specify \code{x} and \code{y} parameters to
#'     identify columns in data for longitude and latitude information
#' @param x A numeric vector providing longitude of village/community locations
#'     (default). If \code{data} is specified, \code{x} must be a character value
#'     specifying the variable name in \code{data} holding the longitude
#'     information of the village/community locations
#' @param y A numeric vector providing latitude of village/community locations
#'     (default). If \code{data} is specified, \code{y} must be a character value
#'     specifying the variable name in \code{data} holding the latitude
#'     information of the village/community locations
#' @param query A query matrix of sampling locations with at least information
#'     on longitude and latitude coordinates. Currently, the default expected
#'     \code{query} is that of an object of class \code{SpatialPoints} produced
#'     by \code{spsample()} in the \code{gstat} package with longitude and
#'     latitude data found at second and third columns
#'
#' @return A data frame of selected nearest sampling village/community locations
#'
#' @author Farah Mohamad Ibrahim <abdu.ff@gmail.com>
#'
#' @examples
#' #
#'
#' @export
#'
#
################################################################################

get_nearest_point <- function(data, x, y, query) {
  #
  # Create concatenating object
  #
  near.point <- NULL
  #
  #
  #
  for(i in 1:length(data)) {

    near.point1 <- gdist(x$x[i], x$y[i], y[,2], y[,3],
                         units = "km", a = 6378137.0, b = 6356752.3142)

    near.point2 <-  c(y$id[which(near.point1 == min(near.point1))],
                      y$x[which(near.point1 == min(near.point1))],
                      y$y[which(near.point1 == min(near.point1))],
                      y$village[which(near.point1 == min(near.point1))],
                      y$locality[which(near.point1 == min(near.point1))],
                      min(near.point1))

    near.point <- rbind(near.point, near.point2)
  }
  near.point <- as.data.frame(near.point)
  names(near.point) <- c("id", "x", "y", "village", "locality", "d")
  rownames(near.point) <- NULL
  near.point[,1] <- as.numeric(near.point[,1])
  near.point[,2] <- as.numeric(near.point[,2])
  near.point[,3] <- as.numeric(near.point[,3])

  # Remove duplicates
  near.point <- near.point[!duplicated(near.point[,-6]),]
  return(near.point)
}
