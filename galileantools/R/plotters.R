#' Plot trajectories: observed noisy ground data and model fit if provided
#' @param data data.frame with t,x,y
#' @param model_par optional: named vector c(u_x,u_y,v,h) for model overlay
#' @export
#' @importFrom stats lm coef optim rnorm
#' @importFrom ggplot2 ggplot aes geom_point geom_line labs
plot_trajectories <- function(data, model_par = NULL){
  p1 <- ggplot(data, aes(x = t, y = y)) +
    geom_point(size = 1) + geom_line(alpha = 0.4) +
    labs(title = "Vertical motion (y) over time", x = "t (s)", y = "y (m)")

  p2 <- ggplot(data, aes(x = t, y = x)) +
    geom_point(size = 1) + geom_line(alpha = 0.4) +
    labs(title = "Horizontal motion (x) over time", x = "t (s)", y = "x (m)")

  if(!is.null(model_par)){
    tgrid <- seq(min(data$t), max(data$t), length.out = 200)
    xmod <- (model_par["u_x"] + model_par["v"]) * tgrid
    ymod <- model_par["u_y"] * tgrid + model_par["h"] - 0.5 * 9.81 * tgrid^2
    dfm <- data.frame(t = tgrid, x = xmod, y = ymod)

    p1 <- p1 + geom_line(data = dfm, aes(x = t, y = y), color = "blue", size = 1)
    p2 <- p2 + geom_line(data = dfm, aes(x = t, y = x), color = "blue", size = 1)
  }

  list(plot_y = p1, plot_x = p2)
}
