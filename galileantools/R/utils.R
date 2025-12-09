#' Compute numerical acceleration from data (central differences)
#' @param data data.frame with t,x,y
#' @return data.frame with t, ax, ay
#' @export
numerical_acceleration <- function(data){
  t <- data$t
  dt <- diff(t)
  vx <- diff(data$x) / dt
  vy <- diff(data$y) / dt
  ax <- diff(vx) / dt[-1]
  ay <- diff(vy) / dt[-1]
  t_mid <- t[-c(1,2)]
  data.frame(t = t_mid, ax = ax, ay = ay)
}
