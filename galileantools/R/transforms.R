#' Apply a 1D Galilean boost along x
#'
#' @param pos data.frame or matrix with columns x,y,z
#' @param t numeric vector of times (same length as rows of pos)
#' @param v numeric scalar (velocity along x)
#' @return data.frame with x,y,z,t transformed (to the other frame)
#' @examples
#' pos <- data.frame(x = c(0,1), y = c(0,0), z = c(0,0))
#' galilean_transform(pos, t = c(0,1), v = 5)
#' @export
galilean_transform <- function(pos, t, v){
  if(is.data.frame(pos)) pos <- as.matrix(pos)
  if(nrow(pos) != length(t)) stop("nrow(pos) must equal length(t)")
  x <- pos[,1] - v * t   # transform from platform frame to ground frame
  data.frame(x = x, y = pos[,2], z = pos[,3], t = t)
}

#' Return the 2x2 Galilean matrix for x,t (1D)
#' @param v numeric scalar (velocity)
#' @return 2x2 matrix
#' @export
galilean_matrix <- function(v){
  matrix(c(1, -v, 0, 1), nrow = 2, byrow = TRUE)
}

