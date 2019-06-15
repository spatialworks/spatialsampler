test_that("calculate_area works", {
  expect_equal(length(calculate_area(d = 10)), 2)
  expect_is(calculate_area(d = 10), "data.frame")
})

test_that("calculate_area correct", {
  expect_equal(calculate_area(d = 10)[ , 1], tan(30 * (pi / 180)) * (9 / 4) * 10 ^ 2)
  expect_equal(calculate_area(d = 10)[ , 2], ((3 * sqrt(3)) / 2) * 10 ^ 2)
  expect_equal(calculate_area(d = 10, digits = 2)[ , 1], 129.90)
})
