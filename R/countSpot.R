#' Counting spots per timepoints
#'
#' @param Spots_df a dataframe created with Spots.as.Dataframe
#' @param timepoint column of timepoints
#' @importFrom dplyr enquo
#' @importFrom dplyr group_by
#' @importFrom dplyr left_join
#' @importFrom dplyr summarize
#'
#' @return a dataframe
#' @export
#'
#' @examples
countSpot <- function(Spots_df, timepoint) {

  timepoint <- enquo(timepoint)
  nb_nuclei <- Spots_df %>%
    group_by((!!timepoint)) %>%
    summarize(nb = n())

  left_join(Spots_df, nb_nuclei)
}


