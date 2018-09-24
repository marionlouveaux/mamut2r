#' Check order of Track_df
#' Function checks if spots source and spots target in Track_df are inverted compared to frame and invert if necessary so that source always corresponds to the smaller frame and target to the biggest one.
#'
#' @param Tracks_df a dataframe created with Tracks.as.dataframe()
#' @param Spots_df a dataframe created with Spots.as.dataframe()
#' @importFrom dplyr ends_with
#' @importFrom dplyr if_else
#' @importFrom dplyr left_join
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#'
#' @return a dataframe with reordered source and targets
#' @export
#'
#' @examples

checkTrack <- function(Tracks_df, Spots_df) {
  idFrame <- Spots_df %>%
    select(ID, FRAME)

  df <- Tracks_df %>%
    left_join(idFrame, by=c("SPOT_SOURCE_ID" = "ID")) %>%
    mutate(SPOT_SOURCE_FRAME = FRAME) %>%
    select(-FRAME) %>%
    left_join(idFrame, by=c("SPOT_TARGET_ID" = "ID")) %>%
    mutate(SPOT_TARGET_FRAME = FRAME) %>%
    select(-FRAME)

  df <- df %>%
    mutate(SPOT_SOURCE_ID_orig = SPOT_SOURCE_ID,
           SPOT_TARGET_ID_orig = SPOT_TARGET_ID,
           SPOT_SOURCE_FRAME_orig = as.numeric(SPOT_SOURCE_FRAME),
           SPOT_TARGET_FRAME_orig = as.numeric(SPOT_TARGET_FRAME)) %>%
    mutate(SPOT_SOURCE_ID = if_else(SPOT_SOURCE_FRAME_orig>SPOT_TARGET_FRAME_orig,
                                    SPOT_TARGET_ID_orig, SPOT_SOURCE_ID_orig),
           SPOT_TARGET_ID = if_else(SPOT_SOURCE_FRAME_orig>SPOT_TARGET_FRAME_orig,
                                    SPOT_SOURCE_ID_orig, SPOT_TARGET_ID_orig),
           SPOT_SOURCE_FRAME = if_else(SPOT_SOURCE_FRAME_orig>SPOT_TARGET_FRAME_orig,
                                       SPOT_TARGET_FRAME_orig, SPOT_SOURCE_FRAME_orig),
           SPOT_TARGET_FRAME = if_else(SPOT_SOURCE_FRAME_orig>SPOT_TARGET_FRAME_orig,
                                       SPOT_SOURCE_FRAME_orig, SPOT_TARGET_FRAME_orig)
    ) %>%
    select(-ends_with("_orig"))
  return(df)
}



