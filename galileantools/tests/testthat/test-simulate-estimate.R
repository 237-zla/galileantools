test_that("simulate and estimate recover v approximately", {
  set.seed(1)
  dat <- simulate_projectile(u0 = c(5,12), pos0 = c(0,1.5),
                             t = seq(0,2.5,0.05), v_platform = 15, noise_sd = 0.1)
  e <- estimate_platform_velocity(dat, known_u_x = 5)
  expect_true(abs(e$v_est - 15) < 0.5) # tol depends on noise
})
