#' Converting HEX colors to MaMut integer color scale
#'
#' @param x an HEX color
#'
#' @importFrom grDevices col2rgb rgb
#'
#' @return an integer
#' @export
#'
#' @examples

hex2int <- function(x) {
  myRGBA <- c(col2rgb(x), 255)
  HEX_ord <- rgb(myRGBA[3], myRGBA[2], myRGBA[1], myRGBA[4], maxColorValue = 255)
  col2rgb(HEX_ord, alpha = TRUE) %>%
    as.raw() %>%
    rawToBits() %>%
    packBits(type = "integer")
}


