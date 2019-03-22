################################################################################
#
#' create_buffer
#'
#' Function to create a buffer around a SpatialPolygons or SpatialPolygonsDataFrame
#' object. This is a wrapper for \code{gBuffer()} function from package \code{rgeos}
#' adding transformation of planar coordinates to appropriate projected coordinates
#' to enable creation of buffer.
#'
#' @param x A class SpatialPolygons or SpatialPolygonsDataFrame object defining
#'     the area to be buffered
#' @param buffer A numeric value for distance (in kilometres) to expand the
#'     borders of the given spatial object \code{x}. Negative values allowed.
#' @param country Name of country where sampling area is located. This is used
#'     to determine the appropriate UTM projection to transform \code{x}
#'
#' @return A SpatialPolygons with the same CRS as \code{x}
#'
#' @examples
#' #
#'
#' @export
#'
#
################################################################################

create_buffer <- function(x, buffer, country) {
  #
  #
  #
  utm.crs <- get_utm(lon = countryCentroid$lon[countryCentroid$country == country],
                     lat = countryCentroid$lat[countryCentroid$country == country])
  #
  #
  #
  x.utm <- sp::spTransform(x = x,
                           CRSobj = sp::CRS(as.character(utm.crs)))
  #
  # Add buffer
  #
  x.buffer <- rgeos::gBuffer(x.utm, width = buffer * 1000, capStyle = "SQUARE", joinStyle = "BEVEL")
  #
  #
  #
  x.output <- spTransform(x = x.buffer,
                          CRSobj = sp::CRS(sp::proj4string(x)))
  #
  #
  #
  return(x.output)
}







