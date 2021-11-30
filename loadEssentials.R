################################################################################
###                                Purpose                                   ###
################################################################################
## The collective of all of the "basic" necessary steps
##  ---- 
## Author:
##    - M.L. Dubbelaar 
################################################################################
###                   Setup parameters for parallelization                   ###
################################################################################
## Detect the number of cores of the computer
cores <- detectCores()
## Define this number -1 (to not overload the computer)
cl <- makeCluster(cores[1]-2)
## Register the number of cores
registerDoParallel(cl)
################################################################################
##                              GGplot content                                ##
################################################################################
## Define the baseline ggplot theme
ggplotTheme <- theme(axis.text = element_text(size = 8),
                     axis.title = element_text(size = 10),
                     ##panel.background = element_rect(fill = "transparent"), # bg of the panel
                     ##plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
                     panel.grid.major = element_blank(), # get rid of major grid
                     panel.grid.minor = element_blank(), # get rid of minor grid
                     panel.border = element_rect(colour = "black", fill=NA, size=0.5), # Add the border of the image
                     legend.background = element_rect(fill = "transparent"), # get rid of legend bg
                     legend.box.background = element_rect(fill = "transparent")) # get rid of legend panel bg
################################################################################
##                                Fasta writer                                ##
################################################################################
## Make sure that you look though the different df rows to get the information 
## which is necessary to save to a fasta file
 createFastaContent <- function(dataf, column, geneInfo) {
  ## Define an empty list
  linesToWrite <- c()
  for (geneHit in 1:nrow(dataf)) {
    ## Obtain all of the necessary information to write the fasta files
    linesToWrite <- c(linesToWrite,
                      paste0(">sp|", unique(geneInfo[,grepl("uniprot|accession", colnames(geneInfo), ignore.case = T)]), "_DS", rownames(dataf)[geneHit], "| ",
                             unique(geneInfo[,grepl("entry(\\.| )?names", colnames(geneInfo), ignore.case = T)]),
                             " OS=", unique(geneInfo[,grepl("organism", colnames(geneInfo), ignore.case = T)]),
                             " GN=", unique(geneInfo[,grepl("gene(\\.| )?symbol", colnames(geneInfo), ignore.case = T)])),
                      dataf[geneHit, c(column)]
    )
  }
  ## Return the information that needs to be written to the fasta file
  return(linesToWrite)
}
