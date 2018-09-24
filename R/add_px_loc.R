# Adding positions in pixels to Spots dataframe

#' Calculating coordinates in pixels
#'
#' @param Spots_df a dataframe with spots information and coordinates in microns
#' @param xres resolution in microns for the x dimension
#' @param yres resolution in microns for the y dimension
#' @param zres resolution in microns for the z dimension
#' @param x_m x coordinates in pixels
#' @param y_m y coordinates in pixels
#' @param z_m z coordinates in pixels
#' @importFrom dplyr enquo
#' @importFrom dplyr mutate
#'
#' @return dataframe with three new columns
#' @export
#'
#' @examples
add_px_loc <- function(Spots_df,
                       xres = 0.1625,
                       yres = 0.1625,
                       zres = 0.250,
                       x_m,
                       y_m,
                       z_m) {
  x_m <- enquo(x_m)
  y_m <- enquo(y_m)
  z_m <- enquo(z_m)
  Spots_df <- mutate(Spots_df, x_px = (!!x_m)/xres,
                     y_px = (!!y_m)/yres,
                     z_px = (!!z_m)/zres)
  return(Spots_df)
}


