################################################################################
#
#' nearestPoint
#'
#' Function to select nearest community to a given sampling point (usually the
#' centroid of a square grid for CSAS or of a hexagonal grid for S3M)
#'
#' @param data A matrix or data frame of input sampling locations to which nearest
#'     village locations are to be matched. Data frame should contain at least
#'     information on longitude and latitude coordinates
#' @param x1 A character value specifying the variable name in \code{input}
#'     holding the longitude information of the sampling locations
#' @param y1 A character value specifying the variable name in \code{input}
#'     holding the latitude information of the sampling locations
#' @param query A data frame of village/community locations with at least
#'     information on longitude and latitude coordinates from which to query for
#'     nearest point
#' @param x2 A character value specifying the variable name in \code{query}
#'     holding the longitude information of the village/community locations
#' @param y2 A character value specifying the variable name in \code{query}
#'     holding the latitude information of the village/community locations
#' @param n Number of nearest village/community locations to select. Default
#'     is 1
#' @param duplicate Logical. If TRUE, keep duplicate samples. If FALSE, remove
#'     duplicate samples.
#'
#' @return A data frame of selected nearest sampling village/community locations
#'
#' @author Farah Mohamad Ibrahim <abdu.ff@gmail.com>
#'
#' @examples
#' # Use nearestPoint() with test sampling points in Sennar
#' sennar <- subset(sudan01, STATE == "Sennar")
#' samp.points <- sp::spsample(sennar, type = "hexagonal", n = 20)
#' nearestPoint(data = samp.points@coords, x1 = "x", y1 = "y",
#'              query = sennar_villages, x2 = "x", y2 = "y",
#'              n = 3)
#'
#' @export
#'
#
################################################################################

nearestPoint <- function(data, x1, y1,
                         query, x2, y2,
                         n = 1,
                         duplicate = FALSE) {
  #
  # Create concatenating object
  #
  near.point <- NULL
  #
  # Check that x1, y1, x2, y2 are character
  #
  if(class(x1) != "character" | class(y1) != "character" | class(x2) != "character" | class(y2) != "character") {
    stop("x1 and/or y1 and/or x2 and/or y2 is/are not character. Try again")
    }
  #
  # Cycle through rows of data
  #
  for(i in 1:nrow(data)) {
    #
    # Get distance between current sampling point and vector of villages
    #
    near.point1 <- mapply(FUN = Imap::gdist, lon.2 = query[ , x2], lat.2 = query[ , y2],
                          MoreArgs = list(data[i, x1], data[i, y2], units = "km"))
    #
    # Find the village nearest to the sampling point
    #
    near.point2 <- query[which(near.point1 %in% tail(sort(x = near.point1, decreasing = TRUE), n = n)), ]
    #
    # Add sampling point id
    #
    near.point2 <- data.frame("spid" = rep(i, n),
                              near.point2,
                              "d" = tail(sort(x = near.point1, decreasing = TRUE), n = n))
    #
    # Concatenate villages
    #
    near.point <- data.frame(rbind(near.point, near.point2))
  }
  #
  # Remove duplicates
  #
  if(duplicate == FALSE) {
    near.point <- near.point[!duplicated(near.point[ , c(x2, y2)]), ]
  }
  #
  # Return output
  #
  return(near.point)
}
