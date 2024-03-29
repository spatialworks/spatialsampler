country <- c("Sudan", "Ethiopia", "Kenya", "Somalia", "Uganda", "Rwanda",
             "Zambia", "Nigeria", "Niger", "Burkina Faso", "Liberia",
             "Sierra Leone", "Mozambique", "Tanzania", "Jordan", "Philippines",
             "South Africa", "Bangladesh", "Chad")

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
         "Sierra Leone 1968 / UTM zone 29N",
         "Moznet / UTM zone 38S",
         "Arc 1960 / UTM zone 37S",
         "ED50 / UTM zone 37N",
         "WGS 84 / UTM zone 51N",
         "WGS 84 / UTM zone 34S",
         "WGS 84 / UTM zone 46N",
         "WGS 84 / UTM zone 33N")

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
          "+proj=utm +zone=29 +ellps=WGS84 +datum=WGS84 +units=m +no_defs",
          "+proj=utm +zone=28 +ellps=clrk80 +towgs84=-88,4,101,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=38 +south +ellps=WGS84 +towgs84=0,0,0,-0,-0,-0,0 +units=m +no_defs",
          "+proj=utm +zone=37 +south +ellps=clrk80 +towgs84=-160,-6,-302,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=37 +ellps=intl +towgs84=-87,-98,-121,0,0,0,0 +units=m +no_defs",
          "+proj=utm +zone=51 +datum=WGS84 +units=m +no_defs",
          "+proj=utm +zone=34 +south +datum=WGS84 +units=m +no_defs",
          "+proj=utm +zone=46 +datum=WGS84 +units=m +no_defs",
          "+proj=utm +zone=33 +datum=WGS84 +units=m +no_defs")

epsg <- c("20135", "20138", "21097", "20539", "21095", "32736", "20934", "26322",
          "32631", "32630", "4251", "2162", "5629", "21037", "23037", "32651", "32734", "32646", "32633")

map_projections <- data.frame(country, utm, proj, epsg)

write.csv(map_projections, "data-raw/map_projections.csv", row.names = FALSE)

usethis::use_data(map_projections, overwrite = TRUE)
