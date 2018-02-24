################################################################################
#
#' plot_tri
#'
#' Function to suppress drawing long-sided triangles
#'
#' @param x A SpatialPolygonsDataFrame object of \code{Delaunay triangulation}
#'     output of function \code{gDelaunayTriangulation()}
#' @param border Colour of border to use when plotting the triangles
#' @param qTSL Maximum side length to be allowed to draw sides of triangles.
#'     Value can be between 0 to 1. Default value is 0.975.
#' @return Delaunay triangulation of selected sampling villages
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

plot_tri <- function(x, border, qTSL) {
  #
  # Create concatenating object
  #
  distDF <- NULL
  #
  # Cycle through each triangle of x
  #
  for(i in 1:length(x)) {
    #
    # Calculate distances between three points of triangle
    #
    d1 <- Imap::gdist(x@polygons[[i]]@Polygons[[1]]@coords[,1][1],
                      x@polygons[[i]]@Polygons[[1]]@coords[,2][1],
                      x@polygons[[i]]@Polygons[[1]]@coords[,1][2],
                      x@polygons[[i]]@Polygons[[1]]@coords[,2][2],
                      units = "km")

    d2 <- Imap::gdist(x@polygons[[i]]@Polygons[[1]]@coords[,1][2],
                      x@polygons[[i]]@Polygons[[1]]@coords[,2][2],
                      x@polygons[[i]]@Polygons[[1]]@coords[,1][3],
                      x@polygons[[i]]@Polygons[[1]]@coords[,2][3],
                      units = "km")

    d3 <- Imap::gdist(x@polygons[[i]]@Polygons[[1]]@coords[,1][3],
                      x@polygons[[i]]@Polygons[[1]]@coords[,2][3],
                      x@polygons[[i]]@Polygons[[1]]@coords[,1][1],
                      x@polygons[[i]]@Polygons[[1]]@coords[,2][1],
                      units = "km")
    #
    # Concatenate calculated distances for current triangle
    #
    dist <- cbind(d1, d2, d3)
    #
    # Concatenate calculated distances of current triangle with previous triangles
    #
    distDF <- data.frame(rbind(distDF, dist))
  }
  #
  # Determine which sides to drop
  #
  out <- ifelse(distDF[,1] >= quantile(distDF, probs = qTSL), 1,
           ifelse(distDF[,2] >= quantile(distDF, probs = qTSL), 1,
             ifelse(distDF[,3] >= quantile(distDF, probs = qTSL), 1, 0)))
  #
  # Cycle through the sides of the triangles
  #
  for(j in which(out != 1)) {
    polygon(x@polygons[[j]]@Polygons[[1]]@coords, border = border)
  }
}
