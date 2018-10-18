#' Get information relative to registration in ViewTransform node of Big Data Viewer files
#' Registration based on affine transforms, one or several, written as a vector of 12 indices
#' This vector can be transformed as a 4x4 matrix by adding 0,0,0,1 at the end of the vector and reading it by row.
#'
#' @param Registration List of registration
#' @param name name of the registration
#'
#' @importFrom dplyr mutate everything as_tibble rename select
#' @importFrom purrr map_dfr
#' @export

get_registration <- function(Registration, name) {
  id_viewtransform <- which(names(Registration) == "ViewTransform")

  Registration_df <- Registration[id_viewtransform] %>%
    map_dfr(as_tibble) %>%
    rename(AffineTransform = affine,
           Type = .attrs) %>%
    mutate(Timepoint = Registration$.attrs["timepoint"],
           Setup = Registration$.attrs["setup"],
           index = paste("ViewTransform", formatC(1:n(), flag = "0", width = nchar(n()))),
           regis_name = name
    ) %>%
    select(regis_name, index, everything())

  Registration_df
}
