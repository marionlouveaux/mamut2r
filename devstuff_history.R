usethis::use_build_ignore("devstuff_history.R")

# Description
library(desc)

unlink("DESCRIPTION")
my_desc <- description$new("!new")

my_desc$set(Package = "mamut2r")
my_desc$set_version("0.0.0.9000")
my_desc$set(Title = "Import of MaMuT xml file into R")
my_desc$set(Description = "Imports data coming from .xml files generated with the Fiji MaMuT plugin for lineage and tracking of biological objects.")
my_desc$set("Authors@R", 'c(
            person("Marion", "Louveaux", email = "marion.louveaux@gmail.com", role = c("aut", "cre"))
)')
my_desc$set("VignetteBuilder", "knitr")
my_desc$set("URL", "https://github.com/marionlouveaux/mamut2r")
my_desc$set("BugReports", "https://github.com/marionlouveaux/mamut2r/issues")
my_desc$set("BiocViews", "rhdf5")
my_desc$del("Maintainer")
my_desc$write(file = "DESCRIPTION")

# Licence
usethis::use_gpl3_license("Marion Louveaux")

# Add dependencies to Description
usethis::use_pipe()

# Readme
usethis::use_readme_rmd()
usethis::use_code_of_conduct()
usethis::use_news_md()
usethis::use_appveyor()

# devtools::install_bioc("rhdf5")
source("https://bioconductor.org/biocLite.R")
biocLite("rhdf5", suppressUpdates = TRUE)
# usethis::use_roxygen_md()
# devtools::install_github("ThinkR-open/attachment")
attachment::att_to_description(extra.suggests = "pkgdown") #pkg_ignore = "rhdf5"
attachment::create_dependencies_file(field = c("Depends", "Imports", "Suggests"))

# Run Vignette
devtools::build_vignettes()

# Test pkgdown
pkgdown::build_site()
