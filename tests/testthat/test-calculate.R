test_that("calculate_area works", {
  expect_equal(length(calculate_area(d = 10)), 2)
  expect_is(calculate_area(d = 10), "data.frame")
})
