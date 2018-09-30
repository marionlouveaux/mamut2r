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
# usethis::use_roxygen_md()
# devtools::install_github("ThinkR-open/attachment")
devtools::document()
# attachment::att_to_description() #pkg_ignore = "rhdf5"
# (temporary script)
library(attachment)
pkg_name <- "mamut2r"
path.d <- "DESCRIPTION"
depends <- c(att_from_namespace("NAMESPACE", document = TRUE),
             att_from_rscripts("R"))

vg <- att_from_rmds()
suggests <- vg[!vg %in% c(depends, pkg_name)]

tmp <- lapply(depends, function(x) devtools::use_package(x,
                                                         type = "Imports", pkg = dirname(path.d)))
tmp <- lapply(unique(c(suggests)),
              function(x) devtools::use_package(x, type = "Suggests",
                                                pkg = dirname(path.d)))
usethis::use_tidy_description()

# Run Vignette
devtools::build_vignettes()

# Readme
usethis::use_readme_rmd()
usethis::use_code_of_conduct()
