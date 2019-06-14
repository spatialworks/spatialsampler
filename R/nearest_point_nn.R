################################################################################
#
#' Function to select nearest community to a given sampling point (usually the
#' centroid of a square grid for CSAS or of a hexagonal grid for S3M) based on
#' a nearest neighbour algorithm using Euclidean calculations
#'
#' @param data An input data frame or matrix containing longitude and latitude
#'     coordinates of village locations from which to find nearest neighbour
#' @param x1 A character value specifying the variable name in \code{data}
#'     containing the longitude coordinates
#' @param y1 A character value specifying the variable name in \code{data}
#'     containing the latitude coordinates
#' @param query an object of class `SpatialPoints` containing sampling point
#'     locations. This is usually the output from applying `spsample()` function
#'     from package `gstat` to create an even spatial sample across the entire
#'     sampling area
#' @param x2 A character value specifying the variable name in \code{query}
#'     containing the longitude coordinates
#' @param y2 A character value specifying the variable name in \code{query}
#'     containing the latitude coordinates
#' @param n A numeric value speciyfing the maximum number of nearest neighbours
#'     to search for
#' @param duplicate Logical. Specify if duplicate selected villages are to be
#'     kept or discarded. Default is FALSE (discard).
#'
#' @return A subset data frame of \code{data} of selected villages/communities
#'     nearest to the sampling points with a new variable \code{d} indicating
#'     the distance of the village/community to the sampling point (in coordinate
#'     units). If \code{duplicate} is TRUE, the result has number of rows equal
#'     to \code{nrow(query)}
#'
#' @author Ernest Guevarra <ernest@guevarra.io>
#'
#' @examples
#' # Use get_nn() with test sampling points in Sennar to find 3 nearest communities
#' # from the sampling points
#' sennar <- subset(sudan01, STATE == "Sennar")
#' samp.points <- sp::spsample(sennar, type = "hexagonal", n = 10)
#' get_nn(data = sennar_villages, x1 = "x", y1 = "y",
#'        query = samp.points, x2 = "x", y2 = "y",
#'        n = 3)
#'
#' @export
#'
#
################################################################################

get_nn <- function(data, x1, y1, query, x2, y2, n, duplicate = FALSE) {
  #
  # Check that x1, y1, x2, y2 are character
  #
  if(class(x1) != "character" | class(y1) != "character" | class(x2) != "character" | class(y2) != "character") {
    stop("x1 and/or y1 and/or x2 and/or y2 is/are not character. Try again", call. = TRUE)
  }
  #
  # Find n nearest neighbours
  #
  near.index <- FNN::get.knnx(data = data[ , c(x1, y1)],
                              query = query@coords[ , c(x2, y2)],
                              k = n)
  #
  # Subset data for n nearest neighbours
  #
  near.point <- data[near.index$nn.index, ]
  #
  # Add distance (d) in coordinate units to near.point data.frame
  #
  near.point <- data.frame(near.point, d = c(near.index$nn.dist))
  #
  # Remove duplicates
  #
  if(duplicate == FALSE) {
    near.point <- near.point[!duplicated(near.point[ , c(x1, y1)]), ]
  }
  #
  # Return output
  #
  return(near.point)
}

