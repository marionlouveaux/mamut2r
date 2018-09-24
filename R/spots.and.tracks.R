#' Combining spots and tracks dataframes
#'
#' @param Spots_df dataframe created with Spots.as.dataframe()
#' @param Tracks_df dataframe created with Tracks.as.dataframe()
#' @importFrom dplyr distinct
#' @importFrom dplyr left_join
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom dplyr starts_with
#'
#' @return a dataframe
#' @export
#'
#' @examples

spots.and.tracks <- function(Spots_df, Tracks_df) {

  Spots_Tracks <- Spots_df %>%
    left_join(
      Tracks_df %>%
        select(SPOT_SOURCE_ID, TRACK_ID) %>%
        distinct(),
      by = c("ID" = "SPOT_SOURCE_ID")) %>%
    left_join(
      Tracks_df %>%
        select(SPOT_TARGET_ID, TRACK_ID) %>%
        distinct(),
      by = c("ID" = "SPOT_TARGET_ID")) %>%
    mutate(TRACK_ID = ifelse(is.na(TRACK_ID.y), TRACK_ID.x, TRACK_ID.y)) %>%
    select(-starts_with("TRACK_ID.")) #%>%
  # mutate(x1 = x, y1=y, z1=z) %>%
  # select(-x,-y,-z)
  return(Spots_Tracks)
}




