# Add this fil in .Rbuildignore
usethis::use_build_ignore("dev_history.R")


## Fill the DESCRIPTION ----
# function to do inspired by the golem one


## Configure git ---
## -------------

# Initialize a repo
usethis::use_git()
# Add a repo
gh::gh("POST /user/repos", name = "benutils")
usethis::git_vaccinate()
usethis::git_sitrep()
usethis::use_git()
# In the terminal :
# git init
# git add .
# git commit -m "first commit"
# git branch -M main
# git remote add origin https://github.com/BenjaminLouis/benutils.git
# git push -u origin main
