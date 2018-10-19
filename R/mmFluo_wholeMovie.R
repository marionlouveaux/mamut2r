#' Calculate a mean and median fluorescent value for the whole movie over all spots
#'
#' @param Spots_df a dataframe containing the spots coordinates
#' @param all_cells fluorescent values collected in a cube of a given size around each spot location
#' @importFrom dplyr mutate
#'
#' @return a dataframe
#' @export
#'

mmFluo_wholeMovie <- function(Spots_df, all_cells) {

  fluo_perT <- lapply(all_cells, function(time){
    unlist(lapply(time, function(x){x[[3]]}))
  })

  Spots_df %>%
    mutate(meanFluo_wholeMovie = mean(unlist(fluo_perT)),
           medianFluo_wholeMovie = median(unlist(fluo_perT))
    )
}



