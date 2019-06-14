################################################################################
#
#' Create the rectangular S3M grid given a value of d of the farthest distance of
#' a village from a sampling point.
#'
#' @param input A class SpatialPolygons or SpatialPolygonsDataFrame object of the
#'     area to be gridded.
#' @param d A numeric value for length (in kilometres) of the maximum distance
#'     of a village/community from a sampling point. This can be the output of
#'     the function \code{calculate_d()}
#' @param buffer A numeric value for distance (in kilometres) to expand the
#'     borders of the given spatial object \code{x}. Negative values allowed.
#' @param country Name of country where sampling area is located. This is used
#'     to determine the appropriate UTM projection to transform \code{input}
#' @param output A character value specifying type of output required. Can be
#'     either of two options: "points" for a class SpatialPoints output of the
#'     sampling point locations based on the S3M grid or "lines" for a class
#'     SpatialLines output of the rectangular S3M grid. Default is "points".
#'
#' @return Either a class SpatialLines object if \code{output} is "lines" or
#'     a class SpatialPoints object if \code{output} is "points"
#'
#' @source based on S3M sampling approach designed by Mark Myatt and
#'     Ernest Guevarra
#'
#' @examples
#'
#' # S3M grid of Sennar state, Sudan based on a d of 12 kms
#' create_s3m_grid(input = sudan01[sudan01$STATE == "Sennar", ],
#'                 d = 12,
#'                 buffer = 6,
#'                 country = "Sudan",
#'                 output = "lines")
#'
#' @export
#'
#
################################################################################

create_s3m_grid <- function(input, d, buffer, country, output = "points") {
  mapbox <- input %>%
    sp::bbox() %>%
    raster::extent() %>%
    methods::as(Class = "SpatialPolygons")

  sp::proj4string(mapbox) <- sp::proj4string(input)

  mapbox <- mapbox %>% create_buffer(buffer = buffer, country = country)

  mapbox <- sp::spTransform(x = mapbox,
                            CRSobj = CRS(as.character(map_projections$proj[map_projections$country == country])))

  x <- seq(from = raster::extent(mapbox)[1],
           to = raster::extent(mapbox)[2],
           by = calculate_length(d = d * 1000))

  x1 <- seq(from = raster::extent(mapbox)[1],
            to = raster::extent(mapbox)[2],
            by = calculate_length(d = d * 1000) * 2)

  x2 <- seq(from = raster::extent(mapbox)[1] + calculate_length(d = d * 1000),
            to = raster::extent(mapbox)[2],
            by = calculate_length(d = d * 1000) * 2)

  y <- seq(from = raster::extent(mapbox)[3],
           to = raster::extent(mapbox)[4],
           by = calculate_height(d = d * 1000))

  y1 <- seq(from = raster::extent(mapbox)[3],
            to = raster::extent(mapbox)[4],
            by = calculate_height(d = d * 1000) * 2)

  y2 <- seq(from = raster::extent(mapbox)[3] + calculate_height(d = d * 1000),
            to = raster::extent(mapbox)[4],
            by = calculate_height(d = d * 1000) * 2)

  coords  <- NULL
  coords1 <- NULL
  coords2 <- NULL

  for(i in 1:length(x)) {
    for(j in 1:length(y)) {
      coords  <- rbind(coords, c(x[i], y[j]))
      coords1 <- rbind(coords1, c(x1[i], y1[j]))
      coords2 <- rbind(coords2, c(x2[i], y2[j]))
    }
  }

  coordsSP <- rbind(coords1, coords2)
  coordsSP <- coordsSP[!is.na(coordsSP[ , 1]), ]
  coordsSP <- coordsSP[!is.na(coordsSP[ , 2]), ]

  coordsSP <- sp::SpatialPoints(coords = coordsSP,
                                proj4string = sp::CRS(sp::proj4string(mapbox)))

  coordsSP <- sp::spTransform(x = coordsSP,
                              CRSobj = sp::CRS(sp::proj4string(input)))

  a <- seq(from = 1, to = nrow(coords), by = length(y))
  b <- seq(from = length(y), to = nrow(coords), by = length(y))

  hline <- NULL

  for(i in 1:length(x)) {
    temp <- sp::Lines(sp::Line(coords[a[i]:b[i], ]), ID = paste("hline", i, sep = ""))
    hline <- c(hline, temp)
  }

  coordsX <- coords[order(coords[ , 2]), ]

  a <- seq(from = 1, to = nrow(coordsX), by = length(x))
  b <- seq(from = length(x), to = nrow(coordsX), by = length(x))

  vline <- NULL

  for(i in 1:length(y)) {
    temp <- sp::Lines(sp::Line(coordsX[a[i]:b[i], ]), ID = paste("vline", i, sep = ""))
    vline <- c(vline, temp)
  }

  allLines <- sp::SpatialLines(c(hline, vline),
                               proj4string = sp::CRS(sp::proj4string(mapbox)))

  allLines <- sp::spTransform(x = allLines,
                              CRSobj = sp::CRS(sp::proj4string(input)))

  if(output == "points") {
    return(coordsSP)
  } else return(allLines)
}




