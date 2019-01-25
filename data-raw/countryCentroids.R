################################################################################
##
library(devtools)
library(ggmap)
library(gadmr)

################################################################################
##
register_google(key = "AIzaSyCa7K4CUhyOLBJUrLZPm4qEwv5yyP9zMKQ")

countryCentroid <- data.frame("country" = list_countries$country, geocode(list_countries$country))

write.csv(countryCentroid, "data-raw/countryCentroid.csv", row.names = FALSE)

usethis::use_data(countryCentroid, overwrite = TRUE)




