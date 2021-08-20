################################################################################
###                                Purpose                                   ###
################################################################################
## Obtain the code and funtions from R scripts that are saved in the lib
## repository from the AG-Walz github page
##  ---- 
## Input: 
##    - scriptName   = The name of the file of interest (example: kmerCalc)
##    - git_mail     = String with the git email (or defined in the .Renviron)
##    - git_password = String with the git password (or defined in the .Renviron)
## Output:
##    - Function is Loaded in the R environment
##  ---- 
## Author:
##    - M.L. Dubbelaar 
################################################################################

source_github <- function(scriptName, git_mail=Sys.getenv("GITHUB_MAIL"), git_password=Sys.getenv("GITHUB_PAT")) {
  ## Load package
  library(httr)
  library(dplyr)

  ## Source R script from Github
  script <-
    GET(
      url = paste0("https://raw.githubusercontent.com/AG-Walz/lib/master/", scriptName, ".R"),
      ## Get the github email and password from .Renviron in the home directory
      ## or use the defined git_mail and git_password
      authenticate(Sys.getenv("GITHUB_MAIL"), Sys.getenv("GITHUB_PAT")),     
      accept("application/vnd.github.v3.raw")
    ) %>%
    content(as = "text")
  
  ## Parse lines and evaluate in the global environment
  eval(parse(text = script), envir= .GlobalEnv)
}
