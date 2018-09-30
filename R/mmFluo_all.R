#' Calculate mean and median fluorescent values for individual cells, per timepoin and for the whole movie
#'
#' @param Spots_df  a dataframe containing the spots coordinates
#' @param all_cells fluorescent values collected in a cube of a given size around each spot location
#'
#' @return a dataframe
#' @export
#'
#' @examples

mmFluo_all <- function(Spots_df, all_cells) {

  Spots_df %>%
    mmFluo(all_cells) %>%
    mmFluo_perT(all_cells) %>%
    mmFluo_wholeMovie(all_cells) %>%
    diffFluo(all_cells, meancol = meanFluo)
}
