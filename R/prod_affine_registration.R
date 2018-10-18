#' Product of affine transformations
#'
#' @param x tibble of Registrations as issued from \code{\link{read_ViewRegistration}}
#'
#' @importFrom purrr map accumulate
#' @importFrom dplyr mutate group_by summarise ungroup
#'
#' @examples
#' v1 <- round(rnorm(12), digits = 2)
#' v2 <- sample(1:10, 12, replace = TRUE)
#' good_res <- crossprod(matrix(c(v1, 0, 0, 0, 1), 4, 4, byrow = TRUE),
#'   matrix(c(v2, 0, 0, 0, 1), 4, 4, byrow = TRUE))
#' x <- tibble(
#'   regis_name = c(1,1),
#'   Timepoint = c(1,1),
#'   Setup = c(1,1),
#'   vector_Affine = list(v1, v2))
#' identical(good_res, prod_affine_registration(x)$prod_affine[[1]])
#' # Both should be equal but solve uses approximations
#' identical(solve(good_res), prod_affine_registration(x)$prod_affine_inv[[1]])
#'

prod_affine_registration <- function(x) {
  if (any(x$Setup != x$Setup[1])) {
    stop("Setup variable should be unique. ",
         "Make sure x comes from read_ViewRegistration()")
  }
  # En fait, regis_name = Timepoint*Setup, mais juste pour etre sur
  Registration_df2 <- x %>%
    mutate(matrix_affine = map(vector_Affine, vect2mat)) %>%
    group_by(regis_name, Timepoint, Setup) %>%
    # Pour debugger a l'interieur ...
    # summarise(prod_Affine = {browser();vector_Affine})
    summarise(prod_affine = list(accumulate(matrix_affine, crossprod) %>% last(.)),
              prod_affine_inv = list(accumulate(matrix_affine, crossprod) %>%
                                       last(.) %>% solve())) %>%
    ungroup()


  return(Registration_df2)
}
