## convert df_meanFluo: heatmap color then HEX then MaMuT color

#' Conversion of continuous variable to discrete integers for visualisation in MaMuT
#'
#' @param Spots_df a dataframe created with Spots.as.Dataframe
#' @param my_var continuous variable to convert as discrete HEX, then integer readable by MaMuT
#' @importFrom dplyr enquo mutate
#' @importFrom viridis viridis
#'
#' @return a dataframe
#' @export
#'

heatmap2int <- function(Spots_df, my_var = fluoMean) {
  my_var <- enquo(my_var)
  Spots_df <- Spots_df %>%
    mutate(colorClass = as.numeric(
      cut( (!! my_var),
           breaks = classInt::classIntervals( (!! my_var),
                                              n = 6,
                                              style = "pretty")$brks))) %>%
    mutate(heat = viridis(n = 6)[colorClass]) %>%
    mutate(MANUAL_COLOR = purrr::map(heat, hex2int) )
  return(Spots_df)
}



