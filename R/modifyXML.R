#' Modify MaMuT .xml file
#' Update values of existing parameters and/or add the manual color parameter
#'
#' @param MaMuTpath path to an existing MaMuT .xml file
#' @param newFilename new name for the modified .xml
#' @param Spots_df spot dataframe corresponding to the MaMuT .xml file, with or without the MANUAL_COLOR variable
#' @importFrom dplyr select_if
#' @importFrom purrr pmap_chr
#' @importFrom xml2 xml_replace
#' @importFrom xml2 xml_find_all
#' @importFrom xml2 write_xml read_xml
#'
#' @return a new .xml file
#' @export
#'

modifyXML <- function(MaMuTpath,
                      newFilename = "test.xml",
                      Spots_df) {
  x <- read_xml(MaMuTpath)

  Spots_df_tmp <- Spots_df %>%
    select_if( names(Spots_df) %in% c("ID", "name",
                                      "VISIBILITY", "RADIUS",
                                      "QUALITY", "SOURCE_ID",
                                      "POSITION_T", "POSITION_X",
                                      "POSITION_Y", "FRAME",
                                      "POSITION_Z",
                                      "MANUAL_COLOR"))

  myNode <- xml_find_all(x, './/Spot')
  xml_replace(myNode, pmap_chr(Spots_df_tmp, makeSpotNode))
  write_xml(x, file = newFilename)
}



