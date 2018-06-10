country <- c("Sudan", "Ethiopia", "Kenya", "Somalia", "Uganda", "Rwanda",
             "Zambia", "Nigeria", "Niger", "Burkina Faso", "Liberia",
             "Sierra Leone")

utm <- c("Adindan / UTM zone 35N",
         "Adindan / UTM zone 38N",
         "Arc 1960 / UTM zone 37N",
         "Afgooye / UTM zone 39N",
         "Arc 1960 / UTM zone 35N",
         "WGS 84 / UTM zone 36S",
         "Arc 1950 / UTM zone 34S",
         "Minna / UTM zone 32N",
         "WGS 84 / UTM zone 31N",
         "WGS 84 / UTM zone 30N",
         "Liberia 1964",
         "Sierra Leone 1968")

proj <- c("+proj=utm +zone=35 +ellps=clrk80 +towgs84=-166,-15,204,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=38 +ellps=clrk80 +towgs84=-166,-15,204,0,0,0,0 +units=m +no_defs ",
          "+proj=utm +zone=37 +ellps=clrk80 +towgs84=-160,-6,-302,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=39 +ellps=krass +towgs84=-43,-163,45,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=35 +ellps=clrk80 +towgs84=-160,-6,-302,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=36 +south +datum=WGS84 +units=m +no_defs",
          "+proj=utm +zone=34 +south +a=6378249.145 +b=6356514.966398753 +towgs84=-143,-90,-294,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=32 +ellps=clrk80 +towgs84=-92,-93,122,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=31 +datum=WGS84 +units=m +no_defs",
          "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs",
          "+proj=longlat +ellps=clrk80 +towgs84=-90,40,88,0,0,0,0 +no_defs",
          "+proj=longlat +ellps=clrk80 +towgs84=-88,4,101,0,0,0,0 +no_defs")


map_projections <- data.frame(country, utm, proj)

devtools::use_data(map_projections, overwrite = TRUE)
