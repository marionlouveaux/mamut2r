# No Remotes ----
# Attachments ----
to_install <- c("classInt", "cowplot", "dplyr", "ggplot2", "ggraph", "glue", "grDevices", "igraph", "knitr", "magrittr", "pkgdown", "purrr", "rhdf5", "rmarkdown", "stats", "tibble", "utils", "viridis", "XML", "xml2")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i)) {
      message(paste("     installing", i))
      install.packages(i)
    }

  }