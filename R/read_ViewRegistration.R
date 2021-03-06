#' Get information relative to registration in .xml Big Data Viewer files
#'
#' @param setup filter on setup value. Default to setup = 0.
#' @param XML_BDV xml file generated by the Big Data Viewer (opened to create the first MaMuT annotation file)
#'
#' @importFrom purrr map2_dfr map
#' @importFrom dplyr filter mutate
#'
#' @export

read_ViewRegistration <- function(XML_BDV, setup = 0) {
  AllViewRegistrations <- XML_BDV$ViewRegistrations

  names(AllViewRegistrations)
  id_allviewregistrations <- which(names(AllViewRegistrations) == "ViewRegistration")

  names_regis <- paste0(names(AllViewRegistrations)[id_allviewregistrations],
                        "_", formatC(1:length(id_allviewregistrations),
                                     flag = "0", width = nchar(length(id_allviewregistrations))))

  Registration_df <-
    map2_dfr(AllViewRegistrations[id_allviewregistrations], names_regis, get_registration) %>%
    mutate(vector_Affine = map(AffineTransform,
                               ~strsplit(.x, "\\s") %>%
                                 unlist() %>%
                                 as.numeric())) %>%
    filter(Setup == setup)

  return(Registration_df)
}
