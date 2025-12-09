## ----setup, message=FALSE-----------------------------------------------------
library(galileantools)
set.seed(42)

## Simulation

# We simulate a projectile launched from a platform moving at v = 15 m/s.

dat <- simulate_projectile(u0 = c(5,12), pos0 = c(0,1.5),
t = seq(0,2.565,0.05), v_platform = 15, noise_sd = 0.2)
head(dat)

# Estimate platform velocity (assuming u_x known)

est_lm <- estimate_platform_velocity(dat, known_u_x = 5)
est_lm$v_est
summary(est_lm$lm)

# Joint estimation (u_x, u_y, v, h) via optim

est_joint <- estimate_platform_velocity(dat, known_u_x = NULL, init = c(4,10,10,1))
est_joint$par

# Visualization

plots <- plot_trajectories(dat, model_par = c(u_x=5, u_y=12, v=15, h=1.5))
plots$plot_x
plots$plot_y

# Numerical acceleration check

acc <- numerical_acceleration(dat)
head(acc)

# rough check: mean of ay should be close to -9.81 (noisy / discrete)

mean(acc$ay)


