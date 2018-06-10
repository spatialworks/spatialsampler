################################################################################
#
#' get_nearest_point
#'
#' Function to select nearest community to a given sampling point (usually the
#' centroid of a square grid for CSAS or of a hexagonal grid for S3M) using
#' geodesic calculations based on a specified reference ellipsoid
#'
#' @param data An input data frame or matrix containing longitude and latitude
#'     coordinates of village locations from which to find nearest neighbour
#' @param data.x A character value specifying the variable name in \code{data}
#'     containing the longitude coordinates
#' @param data.y A character value specifying the variable name in \code{data}
#'     containing the latitude coordinates
#' @param query an object of class `SpatialPoints` containing sampling point
#'     locations. This is usually the output from applying `spsample()` function
#'     from package `gstat` to create an even spatial sample across the entire
#'     sampling area
#' @param n Number of nearest villages to select
#' @param ellipsoid Two letter character value specifying the reference ellipsoid
#'     to use for distance calculations
#' @param duplicate Logical. Specify if duplicate selected villages are to be
#'     kept or discarded. Default is FALSE (discard).
#'
#' @return A subset data frame of \code{data} of selected villages/communities
#'     nearest to the sampling points with a new variable \code{d} indicating
#'     the distance of the village/community to the sampling point (in kms). If
#'     \code{duplicate} is TRUE, the result has number of rows equal to
#'     \code{nrow(query)}
#'
#' @author Ernest Guevarra <ernest@guevarra.io>
#'
#' @examples
#' # Use get_nearest_point() with test sampling points in Sennar to find 3 nearest
#' #communities from the sampling points
#' sennar <- subset(sudan01, STATE == "Sennar")
#' samp.points <- sp::spsample(sennar, type = "hexagonal", n = 10)
#' get_nearest_point(data = sennar_villages, data.x = "x", data.y = "y",
#'                   query = samp.points, n = 3)
#'
#' @export
#'
#
################################################################################

get_nearest_point <- function(data, data.x, data.y,
                              query, n = 1,
                              ellipsoid = c("AA", "AN", "??", "BR", "BN",
                                            "CC", "CD", "EB", "EA", "EC",
                                            "EF", "EE", "ED", "RF", "HE",
                                            "HO", "ID", "IN", "KA", "AM",
                                            "FA", "SA", "WD", "WE"),
                              duplicate = FALSE) {
  #
  # Create a SpatialPoints object out of data
  #
  dataSP <- sp::SpatialPoints(coords = data[ , c(data.x, data.y)],
                              proj4string = sp::CRS(sp::proj4string(query)))
  #
  # Get constants for WGS84 reference ellipsoid
  #
  a <- geosphere::refEllipsoids()[geosphere::refEllipsoids()$code == "WE", "a"]
  f <- 1 / geosphere::refEllipsoids()[geosphere::refEllipsoids()$code == "WE", "invf"]
  #
  # Determine constants based on reference ellipsoid used
  #
  if(length(ellipsoid) !=  24 & length(ellipsoid) == 1) {
    a <- geosphere::refEllipsoids()[geosphere::refEllipsoids()$code == ellipsoid, "a"]
    f <- 1 / geosphere::refEllipsoids()[geosphere::refEllipsoids()$code == ellipsoid, "invf"]
  }
  #
  # Check if more than one reference ellipsoid selected
  #
  if(length(ellipsoid) > 1 & length(ellipsoid) != 24) {
    stop("More than one reference ellipsoid specified. Select only one. Try again", call. = TRUE)
  }
  #
  # Check that data.x, data.y are character values
  #
  if(class(data.x) != "character" | class(data.y) != "character") {
    stop("data.x and/or data.y is/are not character. Try again", call. = TRUE)
  }
  #
  # Check that query is a class SpatialPoints object
  #
  if(class(query) != "SpatialPoints") {
    stop("query should be class SpatialPoints object. Try again.", call. = TRUE)
  }
  #
  # Create concatenating object
  #
  near.point <- NULL
  #
  # Cycle through rows of input
  #
  for(i in 1:length(query)) {
      #
      # Get distance between current sampling point and vector of villages
      #
      near.point1 <- geosphere::distGeo(p1 = query[i, ], p2 = dataSP, a = a, f = f) / 1000
      #
      # Find the village nearest to the sampling point
      #
      near.point2 <- data[which(near.point1 %in% tail(sort(x = near.point1, decreasing = TRUE), n = n)), ]
      #
      # Add sampling point id
      #
      near.point2 <- data.frame("spid" = rep(i, n),
                                near.point2,
                                d = tail(sort(x = near.point1, decreasing = TRUE), n = n))
      #
      # Concatenate villages
      #
      near.point <- data.frame(rbind(near.point, near.point2))
  }
  #
  # Check if duplicates are to be removed
  #
  if(duplicate == FALSE) {
    near.point <- near.point[!duplicated(near.point[ , c(data.x, data.y)]), ]
  }
  #
  # Return output
  #
  return(near.point)
}
