# Add this fil in .Rbuildignore
usethis::use_build_ignore("dev_history.R")


## Fill the DESCRIPTION ----
## --------------------

# function to do inspired by the golem one


## Configure git ---
## -------------

# Check credentials
usethis::git_sitrep()
#usethis::git_vaccinate()
#If not see : https://usethis.r-lib.org/articles/articles/git-credentials.html

# Initialize a repo
usethis::use_git()

# Add a repo and connect to github
usethis::use_github()


## Create Common Files ----
## -------------------

usethis::use_mit_license( copyright_holder = "Benjamin Louis" )  # You can set another license here
usethis::use_readme_rmd( open = FALSE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Experimental" )
#usethis::use_news_md( open = FALSE )


## R files ---
## -------

usethis::use_r("find_pattern")

## Tests ---
## -----


## Dependencies ---
## ------------

#usethis::use_test(")

# Add to description
attachment::att_amend_desc(extra.suggests = NULL)

# renv
renv::init()
renv::snapshot(type = "explicit")
renv::restore()
#renv::rebuild()
