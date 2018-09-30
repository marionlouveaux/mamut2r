#' Create a spot node
#' To modify the mamut.xml file.
#'
#' see also documentation here: https://cran.r-project.org/web/packages/xml2/vignettes/modification.html
#' @param ... A spot dataframe
#'
#' @return a character
#' @export
#'
#' @examples
makeSpotNode <- function(...) {
  x <- unlist(list(...))
  paste0("Spot ", paste(paste0(names(x), '="', x, '"'), collapse = " "))
}


