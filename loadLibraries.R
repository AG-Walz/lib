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
    sapply(toInstall, function(x) BiocManager::install(x))
    ## If the library is not available on bioclite, then use install.packages
  } else {
    ## Install the library
    install.packages(x)
  }
})

## Load the necessary libraries()
invisible(lapply(necessaryLibs, library, character.only = T))
