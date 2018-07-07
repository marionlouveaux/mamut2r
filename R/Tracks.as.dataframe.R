#' Convert MaMuT xml Tracks tags to a dataframe
#'
#' @param MaMuT_XML .xml MaMuT Fiji plugin file converted to list with readMaMuT()
#' @keywords Fiji, 3D, MaMuT, xml
#' @export
#' @examples
#' @return Dataframe containing the spot ID, its name, its visibility, its radius, quality, source and position (x, y, z, t).
#' Tracks.as.dataframe()

Tracks.as.dataframe <- function(MaMuT_XML){
  AllTracks <- MaMuT_XML$Model$AllTracks

  names(AllTracks)
  id_alltrack <- which(names(AllTracks) == "Track")

  for (i in 1:length(id_alltrack)){
    names(AllTracks)[id_alltrack[i]] <- paste0(names(AllTracks)[id_alltrack[i]], "_", i)
  }

  Tracks_df <- NULL
  for (i in id_alltrack){

    Tracks <- AllTracks[[i]]
    names(Tracks)
    id_edge <- which(names(Tracks) == "Edge")

    for (index in 1:length(id_edge)){
      names(Tracks)[id_edge[index]] <- paste0(names(Tracks)[id_edge[index]], "_", index)
    }

    Tracks_df_tmp <- NULL
    for (index in 1:length(id_edge)){
      Tracks_df_tmp <- data.frame(rbind(Tracks_df_tmp, Tracks[[index]]), stringsAsFactors = FALSE)
    }

    TRACK_NAME <- Tracks$.attrs["name"]
    TRACK_ID <- Tracks$.attrs["TRACK_ID"]
    TRACK_INDEX <- Tracks$.attrs["TRACK_INDEX"]

    Tracks_df_tmp <- cbind(Tracks_df_tmp, data.frame(TRACK_NAME, TRACK_ID, TRACK_INDEX, stringsAsFactors = FALSE), row.names = NULL)

    Tracks_df <- dplyr::bind_rows(Tracks_df, Tracks_df_tmp)
  }
return(Tracks_df)
}
