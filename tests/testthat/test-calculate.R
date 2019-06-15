test_that("calculate_area works", {
  expect_equal(length(calculate_area(d = 10)), 2)
  expect_is(calculate_area(d = 10), "data.frame")
  expect_equal(calculate_area(d = 10)[ , 1], tan(30 * (pi / 180)) * (9 / 4) * 10 ^ 2)
  expect_equal(calculate_area(d = 10)[ , 2], ((3 * sqrt(3)) / 2) * 10 ^ 2)
  expect_equal(calculate_area(d = 10, digits = 2)[ , 1], 129.90)
})

test_that("calculate_d works", {
  expect_error(calculate_d(area = 130), "Polygon type needs to be specified. Try again.")
  expect_equal(calculate_d(area = 130, geom = "tri"), sqrt((130 * 4) / (tan(30 * (pi / 180)) * 9)))
  expect_equal(calculate_d(area = 130, geom = "hex"), sqrt((130 * 2) / (3 * sqrt(3))))
})

test_that("calculate_height works", {
  expect_equal(calculate_height(d = 6), (sqrt(3) / 2) * 6)
})

test_that("calculate_length works", {
  expect_equal(calculate_length(d = 6), (3 * 6) / 2)
})

test_that("calculate_n works", {
  expect_equal(calculate_n(x = sudan01, d = 10, country = "Sudan"), 7242)
  expect_error(calculate_n(x = sudan01, country = "Sudan"), "Specify either d or area. Try again.")
  expect_error(calculate_n(x = sudan01, d = 10, area = 130, country = "Sudan"), "Specify either d or area, not both. Try again.")
  expect_equal(calculate_n(x = sudan01, area = 130, country = "Sudan"), 14473)
})





