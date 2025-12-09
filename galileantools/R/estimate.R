#' Estimate platform velocity (and optionally u_x,u_y,h) from data
#'
#' If u_x is known, a simple linear regression on x ~ t recovers slope = u_x + v.
#' If u_x unknown, do a joint nonlinear least squares (optim) on x and y.
#'
#' @param data data.frame with columns t, x, y
#' @param known_u_x numeric or NULL. If provided, estimate v = slope - known_u_x
#' @param init numeric initial guesses for optim when joint estimation: c(u_x, u_y, v, h)
#' @return list with estimates and model object
#' @export
estimate_platform_velocity <- function(data, known_u_x = NULL, init = c(4,10,10,1)){
  t <- data$t; x <- data$x; y <- data$y
  if(!is.null(known_u_x)){
    fit <- lm(x ~ t, data = data)
    slope <- coef(fit)["t"]
    v_est <- as.numeric(slope) - known_u_x
    return(list(method = "lm_known_u_x", lm = fit, v_est = v_est))
  } else {
    loss_fn <- function(par, t, x_obs, y_obs, g = 9.81){
      u_x <- par[1]; u_y <- par[2]; v <- par[3]; h <- par[4]
      x_pred <- (u_x + v) * t
      y_pred <- u_y * t + h - 0.5 * g * t^2
      sum((x_obs - x_pred)^2) + sum((y_obs - y_pred)^2)
    }
    opt <- optim(par = init, fn = loss_fn, t = t, x_obs = x, y_obs = y,
                 method = "L-BFGS-B",
                 lower = c(-100, -100, -100, -10), upper = c(100, 100, 100, 10))
    names(opt$par) <- c("u_x", "u_y", "v", "h")
    return(list(method = "optim_joint", opt = opt, par = opt$par))
  }
}
