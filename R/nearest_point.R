################################################################################
#
#' get_nearest_point
#'
#' Function to select nearest community to a given sampling location
#'
#' @param input A matrix or data frame of input sampling locations to which nearest
#'     village locations are to be matched. Data frame should contain at least
#'     information on longitude and latitude coordinates. Currently, the default
#'     expected \code{input} is that of an object of class \code{SpatialPoints}
#'     produced by \code{grid_hexagon()} with longitude and latitude data named
#'     \code{x} and \code{y} respectively
#' @param query A data frame of village/community locations with at least
#'     information on longitude and latitude coordinates from which to query for
#'     nearest point. This argument is optional. If provided, must specify \code{x}
#'     and \code{y} parameters to identify columns in \code{query} for longitude
#'     and latitude information
#' @param x A numeric vector providing longitude of village/community locations
#'     (default). If \code{query} is specified, \code{x} must be a character value
#'     specifying the variable name in \code{query} holding the longitude
#'     information of the village/community locations
#' @param y A numeric vector providing latitude of village/community locations
#'     (default). If \code{data} is specified, \code{y} must be a character value
#'     specifying the variable name in \code{data} holding the latitude
#'     information of the village/community locations
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

get_nearest_point <- function(input,
                              x, y,
                              query) {
  #
  # Create concatenating object
  #
  near.point <- NULL
  #
  # Check if data is NULL
  #
  if(is.null(input)) {
    #
    # Check that x and y are numeric
    #
    if(class(x) != "numeric" | class(y) != "numeric") {
      stop("x and/or y is not numeric. If input is not provided, x and y should be numeric. Try again")
    }
    #
    # Cycle through rows of data
    #
    for(i in 1:length(x)) {

      near.point1 <- Imap::gdist(input$x[i], input$y[i], x, y,
                                 units = "km")

      near.point2 <-  c(y$id[which(near.point1 == min(near.point1))],
                        y$x[which(near.point1 == min(near.point1))],
                        y$y[which(near.point1 == min(near.point1))],
                        y$village[which(near.point1 == min(near.point1))],
                        y$locality[which(near.point1 == min(near.point1))],
                        min(near.point1))

      near.point <- rbind(near.point, near.point2)
    }
  }
  #
  #
  #
  for(i in 1:length(data)) {

    near.point1 <- Imap::gdist(data$x[i], x$y[i], y[,2], y[,3],
                               units = "km")

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
