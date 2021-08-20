################################################################################
###                                Purpose                                   ###
################################################################################
## Generation of kmers from the sequences that are available in a target df
##  ---- 
## Input: 
##    - range   = the length of the kmers (example: 8:12 or 19)
##    - target  = A dataframe that has the sequence hits saved in a column
##                named "Sequence"
## Output:
##    - peptides= A dataframe that adds the kmer column to the existing df
##  ---- 
## Author:
##    - M.L. Dubbelaar 
################################################################################

kmerGenerator <- function(range, target) {
  ## Change the column names that start with "sequence" to a fixed name
  colnames(target)[grepl("^sequence", colnames(target), ignore.case = T)] <- "Sequence"
  ## Create an empty data.frame
  peptides <- data.frame()
  
  ## Loop through the different rows in the target file
  for (rownr in 1:nrow(target)) {
    ## Create the different kmers for class I
    for (peplength in range) {
      ## Walk over the different peptide length possibilities
      for (move in 0:(peplength-1)) {
        ## Create the kmer sequence in the mutation sequencing
        pep <<- ifelse("aa_pos" %in% colnames(target), 
                       paste0(substr(target$Sequence[rownr], target$aa_pos[rownr]-move, target$aa_pos[rownr]-move+peplength-1)),
                       paste0(substr(target$Sequence[rownr], move, move+peplength-1)))
        ## If the length of the kmer is longer than 7 characters
        if (nchar(pep) > peplength-1) {
          ## Increment the peptides with the corresponding information
          peptides <- rbind(peptides,
                            data.frame(pep, target))
        }
      }
    }
  }
  ## Rewrite the colnames to the information from the target file
  colnames(peptides) <- c("kmer", colnames(target))
  ## Return the peptides content
  return(peptides)
}
