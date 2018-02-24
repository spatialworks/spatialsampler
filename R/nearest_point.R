################################################################################
#
#' get_nearest_point
#'
#' Function to select nearest community to a given sampling location
#'
#' @param input A matrix or data frame of input sampling locations to which nearest
#'     village locations are to be matched. Data frame should contain at least
#'     information on longitude and latitude coordinates.
#' @param x1 A character value specifying the variable name in \code{input}
#'     holding the longitude information of the sampling locations
#' @param y1 A character value specifying the variable name in \code{input}
#'     holding the latitude information of the village/community locations
#' @param query A data frame of village/community locations with at least
#'     information on longitude and latitude coordinates from which to query for
#'     nearest point.
#' @param x2 A character value specifying the variable name in \code{query}
#'     holding the longitude information of the village/community locations
#' @param y2 A character value specifying the variable name in \code{query}
#'     holding the latitude information of the village/community locations
#' @param n Number of nearest village/community locations to select
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
                              x1, y1,
                              query,
                              x2, y2,
                              n = 1) {
  #
  # Create concatenating object
  #
  near.point <- NULL
  #
  # Check that x1, y1, x2, y2 are character
  #
  if(x1 != "character" | y1 != "character" | x2 != "character" | y2 != "character") {
    stop("x1 and/or y1 and/or x2 and/or y2 is/are not character. Try again")
    }
  #
  # Cycle through rows of input
  #
  for(i in 1:nrow(input)) {
    #
    # Create concatenating vector for distances
    #
    near.point1 <- NULL
    #
    # Cycle through rows of query
    #
    for(j in 1:nrow(query)) {
      #
      # Get distance between current sampling point and current village
      #
      dist <- tail(Imap::gdist(x1[i], y1[i], x2[j], y2[j], units = "km"), n)
      #
      #
      #
      near.point1 <- c(near.point1, dist)
    }
    #
    # Find the village nearest to the sampling point
    #
    near.point2 <- query[which(near.point1 == min(near.point1)), ]
    #
    # Concatenate villages
    #
    near.point <- data.frame(rbind(near.point, near.point2))
  }
}
