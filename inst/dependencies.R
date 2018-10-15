# No Remotes ----
# Attachments ----
to_install <- c("classInt", "dplyr", "ggplot2", "ggraph", "glue", "grDevices", "igraph", "magrittr", "purrr", "rhdf5", "stats", "tibble", "utils", "viridis", "xml2")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i)) {
      message(paste("     installing", i))
      install.packages(i)
    }

  }