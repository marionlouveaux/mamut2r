#' Takes a 12 coordinates vector and returns a 4x4 matrix
#'
#' @param affine_vect affine transform vector with 12 indices. The vector store the “top” three rows for the 4x4 affine matrix, in a "row major" fashion.
#'
#' @return a 4x4 affine transform matrix, with the top three rows and a last row containing 0,0,0,1
#' @export
#'
#' @examples
#' vect2mat(1:12)

vect2mat <- function(affine_vect) {
  affine_mat <- matrix(data = c(affine_vect, 0,0,0,1), nrow = 4, ncol = 4, byrow = TRUE)
  return(affine_mat)
}
