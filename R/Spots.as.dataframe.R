#' Convert MaMuT xml Spots tags to a dataframe
#'
#' @param MaMuT_XML .xml MaMuT Fiji plugin file converted to list with readMaMuT()
#' @keywords Fiji, 3D, MaMuT, xml
#' @export
#' @examples
#' @return Dataframe containing the spot ID, its name, its visibility, its radius, quality, source and position (x, y, z, t).
#' Spots.as.dataframe()

Spots.as.dataframe <- function(MaMuT_XML){

  AllSpots <- MaMuT_XML$Model$AllSpots
  names(AllSpots)
  id_allspot <- which(names(AllSpots) == "SpotsInFrame")

  apply(t(1:length(id_allspot)), 2, function(x){
    paste0(names(AllSpots)[id_allspot[x]], "_", x-1)
  })

  Spots_df <- NULL
  for (i in id_allspot){

    Spots <- AllSpots[[i]]
    id_spot <- which(names(Spots) == "Spot")

    if (length(id_spot) !=0 ){ # there can be an entry for a given timepoint but no spots
      for (index in 1:length(id_spot)){
        names(Spots)[id_spot[index]] <- paste0(names(Spots)[id_spot[index]], "_", index)
      }

      Spots_df_tmp <- NULL
      for (index in 1:length(id_spot)){
        Spots_df_tmp <- data.frame(dplyr::bind_rows(Spots_df_tmp, Spots[[index]]), stringsAsFactors = FALSE)
      }

      Spots_df <- dplyr::bind_rows(Spots_df, Spots_df_tmp)
    }
  }
  return(Spots_df)
}
