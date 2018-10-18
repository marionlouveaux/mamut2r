#' Get information relative to registration in .xml Big Data Viewer files
#'
#' @param setup filter on setup value. Default to setup = 0.
#'
#' @importFrom purrr map_dfr map
#' @importFrom dplyr mutate
#'
read_ViewRegistration <- function(MaMuT_XML, n_affine = 12, setup = 0) {
  AllViewRegistrations <- MaMuT_XML$ViewRegistrations

  names(AllViewRegistrations)
  id_allviewregistrations <- which(names(AllViewRegistrations) == "ViewRegistration")

  names_regis <- paste0(names(AllViewRegistrations)[id_allviewregistrations],
                        "_", formatC(1:length(id_allviewregistrations),
                                     flag = "0", width = nchar(length(id_allviewregistrations))))

  Registration_df <-
    purrr::map2_dfr(AllViewRegistrations[id_allviewregistrations], names_regis, get_registration) %>%
    mutate(vector_Affine = map(AffineTransform,
                               ~strsplit(.x, "\\s") %>%
                                 unlist() %>%
                                 as.numeric())) %>%
    filter(Setup == setup)

  return(Registration_df)
}
