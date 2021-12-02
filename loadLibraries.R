################################################################################
###                                Purpose                                   ###
################################################################################
## Generation of kmers from the sequences that are available in a target df
##  ---- 
## Input: 
##    - necessaryLibs   = a vector with the libraries of interest (e.g. dplyr)
##                        there often used libraries are defined already
## Output:
##    - Function is Loaded in the R environment
##  ---- 
## Author:
##    - M.L. Dubbelaar 
################################################################################
## Make sure that it is not asked to update the packages 
update.packages(ask = FALSE, Ncpus = 3L)
## Add more information to the necessary libraries
necessaryLibs <- c(necessaryLibs, 
                   "ggplot2", "ggthemes", "ggpubr",  "tidyr", "reshape", "tuple", 
                   "textshape", "purrr", "stringr", "openxlsx", "doParallel", 
                   "foreach" )
## Only first time you install Bioconductor packages
if (!requireNamespace("BiocManager", quietly=TRUE)) {
  install.packages("BiocManager")
}

## Determine which libraries are yet to be installed
unavailable <- setdiff(necessaryLibs, rownames(installed.packages()))
## Go through the unknown libraries
sapply(unavailable, FUN = function(x) {
  ## If it is possible to install the library with BiocManager
  if (length(BiocManager::available(x)) >= 1) {
    ## Then obtain this package and the dependencies
    toInstall <- BiocManager::available(x)
    ## install the available libraries
    sapply(toInstall, function(x) BiocManager::install(x, ask = FALSE, type = "source"))
    ## If the library is not available on bioclite, then use install.packages
  } else {
    ## Install the library
    install.packages(x, ask = FALSE, type = "source")
  }
})

## Load the necessary libraries()
invisible(lapply(necessaryLibs, library, character.only = T))
