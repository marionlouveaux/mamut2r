#' Calculate a mean and median fluorescent value for all spots of each timepoints
#'
#' @param Spots_df a dataframe containing the spots coordinates
#' @param all_cells fluorescent values collected in a cube of a given size around each spot location
#' @importFrom dplyr left_join
#' @importFrom dplyr mutate
#'
#' @return
#' @export
#'
#' @examples

mmFluo_perT <- function(Spots_df, all_cells) {

  all_meanFluo_perT <- lapply(all_cells, function(time){
    meanFluo_perT <- mean(unlist(lapply(time, function(x){x[[3]]})))
    medianFluo_perT <- median(unlist(lapply(time, function(x){x[[3]]})))
    frame <- unique(unlist(lapply(time, function(x){x[[1]]})))
    data.frame(meanFluo_perT = meanFluo_perT, medianFluo_perT = medianFluo_perT, FRAME = as.numeric(frame) )
  })
  all_meanFluo_perT_df <- do.call(rbind.data.frame, all_meanFluo_perT) %>%
    mutate(FRAME = as.character(FRAME))

  left_join(Spots_df, all_meanFluo_perT_df)
}


