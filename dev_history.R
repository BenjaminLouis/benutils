# Add this fil in .Rbuildignore
usethis::use_build_ignore("dev_history.R")


## Fill the DESCRIPTION ----
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
