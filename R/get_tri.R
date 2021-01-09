################################################################################
#
#' A wrapper function to \code{gDelaunayTriangulation()} to perform Delaunay
#' triangulation with additional options to specify thresholds for suppressing
#' long sided triangles
#'
#' @param input A data frame of locations with at least information on longitude
#'     and latitude coordinates of the locations.
#' @param x A character value specifying the variable name of the longitude
#'     information in \code{input}.
#' @param y A character value specifying the variable name of the latitude
#'     information in \code{input}.
#' @param crs A character value specifying the coordinate reference system to
#'     be used for Delaunay triangulation. Default is longlat projection with
#'     datum WGS84 (\code{"+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"})
#' @param qTSL Maximum side length to be allowed to draw sides of triangles.
#'     Value can be between 0 to 1. Default value is 0.975.
#'
#' @return A SpatialPolygons object of Delaunay triangulation of
#'     \code{input} data
#'
#' @examples
#' #
#'
#' @export
#'
#
################################################################################

get_tri <- function(input, x, y,
                    crs = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0",
                    qTSL = 0.975) {
  ## Create Delaunay triangulation of input data
  tri.poly <- rgeos::gDelaunayTriangulation(spgeom = SpatialPoints(coords = input[ , c(x, y)],
                                                                   proj4string = sp::CRS(crs)))

  ## Create concatenating object
  distDF <- NULL

  ## Cycle through each triangle of x
  for(i in seq_len(length(tri.poly))) {
    ## Calculate distances between three points of triangle
    d1 <- Imap::gdist(tri.poly@polygons[[i]]@Polygons[[1]]@coords[,1][1],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,2][1],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,1][2],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,2][2],
                      units = "km")

    d2 <- Imap::gdist(tri.poly@polygons[[i]]@Polygons[[1]]@coords[,1][2],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,2][2],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,1][3],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,2][3],
                      units = "km")

    d3 <- Imap::gdist(tri.poly@polygons[[i]]@Polygons[[1]]@coords[,1][3],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,2][3],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,1][1],
                      tri.poly@polygons[[i]]@Polygons[[1]]@coords[,2][1],
                      units = "km")

    ## Concatenate calculated distances for current triangle
    dist <- cbind(d1, d2, d3)

    ## Concatenate calculated distances of current triangle with previous
    ## triangles
    distDF <- data.frame(rbind(distDF, dist))
  }

  ## Determine which sides to drop
  out <- ifelse(distDF[ , 1] >= quantile(distDF[ , 1], probs = qTSL), FALSE,
           ifelse(distDF[ , 2] >= quantile(distDF[ , 2], probs = qTSL), FALSE,
             ifelse(distDF[ , 3] >= quantile(distDF[ , 3], probs = qTSL), FALSE, TRUE)))

  ## Get subset of Delaunay triangulation SpatialPolygonsDataFrame
  sub.tri.poly <- tri.poly[out]
  return(sub.tri.poly)
}
