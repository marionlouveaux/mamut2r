# Adding positions in pixels to Spots dataframe

#' Calculating coordinates in pixels
#'
#' @param Spots_df a dataframe with spots information and coordinates in microns
#' @param xres resolution in microns for the x dimension
#' @param yres resolution in microns for the y dimension
#' @param zres resolution in microns for the z dimension
#' @param x x coordinates in pixels
#' @param y y coordinates in pixels
#' @param z z coordinates in pixels
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
                       x,
                       y,
                       z) {
  x <- enquo(x)
  y <- enquo(y)
  z <- enquo(z)
  Spots_df <- mutate(Spots_df, x_px = (!!x)/xres,
                     y_px = (!!y)/yres,
                     z_px = (!!z)/zres)
  return(Spots_df)
}


