#' Calculating the coordinates
#' N.B.: pos_world = (3D-HASHING) x (CALIBRATION) x pos_local
#'
#' @param pos_local Coordinates in the local coordinates system of MaMuT Viewer (POSITION_X, POSITION_Y, POSITION_Z) in arbitrary units.
#' @param affTransform 4x4 affine transform from local to world coordinates.
#'
#' @return Coordinates corresponding to the .h5 raw data pixels
#' @export
#'
posLoc2posWorld <- function(pos_local, affTransform) {
  pos_local <- c(pos_local, 1) # we want to transform a point
  pos_world <- affTransform %*% pos_local
  return(pos_world)
}
