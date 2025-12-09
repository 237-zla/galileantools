#' Simulate a projectile launched from a moving platform (2D: x,y)
#'
#' @param u0 numeric vector length 2: initial velocity in platform frame (u_x, u_y)
#' @param pos0 numeric vector length 2: initial position in platform frame (x0,y0)
#' @param t numeric vector of times
#' @param v_platform numeric scalar: platform speed along x (ground frame)
#' @param g gravity (default 9.81)
#' @param noise_sd numeric: standard deviation for Gaussian noise on positions
#' @return data.frame with t, x, y (ground frame, noisy)
#' @export
simulate_projectile <- function(u0 = c(5,12), pos0 = c(0,1.5), t = seq(0,2.5,0.01),
                                v_platform = 15, g = 9.81, noise_sd = 0.2){
  u_x <- u0[1]; u_y <- u0[2]
  x_rel <- pos0[1] + u_x * t
  y_rel <- pos0[2] + u_y * t - 0.5 * g * t^2
  # transform to ground
  x_ground <- x_rel + v_platform * t
  y_ground <- y_rel
  # add noise
  x_noisy <- x_ground + rnorm(length(t), 0, noise_sd)
  y_noisy <- y_ground + rnorm(length(t), 0, noise_sd)
  data.frame(t = t, x = x_noisy, y = y_noisy)
}
