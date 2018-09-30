#' Calculate a mean and median fluorescent value for each cell
#'
#' @param Spots_df a dataframe containing the spots coordinates
#' @param all_cells fluorescent values collected in a cube of a given size around each spot location
#' @importFrom dplyr left_join
#'
#' @return a dataframe
#' @export
#'
#' @examples

mmFluo <- function(Spots_df, all_cells) {

  mmFluo <- lapply(all_cells, function(x){
    oneFrame <- lapply(x, function(y){
      data.frame(frame = as.character(y[[1]]),
                 name = y[[2]],
                 meanFluo = mean(y[[3]]), # mean fluo value per spot
                 medianFluo = median(y[[3]])
      )
    })
    do.call(rbind.data.frame, oneFrame)
  })

  df_meanFluo <- do.call(rbind.data.frame, mmFluo)
  all_data <- left_join(x = Spots_df, y = df_meanFluo)

  return(all_data)
}


