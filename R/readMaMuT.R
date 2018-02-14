#' Read MaMuT xml file
#'
#' This function is a wrapper around xmlToList function to read xml files from MaMuT plugin.
#' @param MaMuTpath path to .xml MaMuT Fiji plugin file
#' @keywords Fiji, 3D, MaMuT, xml
#' @export
#' @examples
#' @return a list of all fields from MaMuT xml file.
#' readMaMuT()

readMaMuT <- function(MaMuTpath){
  XML::xmlToList(MaMuTpath)
}

