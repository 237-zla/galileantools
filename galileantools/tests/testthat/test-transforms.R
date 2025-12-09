test_that("galilean_transform preserves time and composes", {
  pos <- data.frame(x = c(0,1,2), y = 0, z = 0)
  t <- c(0,1,2)
  out <- galilean_transform(pos, t, v = 5)
  expect_equal(out$t, t)

  # compose: transform by v then by -v returns original x positions
  out2 <- galilean_transform(out, t, v = -5)
  expect_equal(round(out2$x, 6), round(pos$x, 6))
})
