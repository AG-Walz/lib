################################################################################
###                                Purpose                                   ###
################################################################################
## The purpose of this script is to split the protein group accessions and make 
## sure that the multimappers are rewritten to one protein per row
################################################################################
###                               Manual steps                               ###
################################################################################
## Clear the R environment
rm(list = ls())
## Define an input directory where the files are stored in a excel format
folder <- "C:/Users/ane.IMMUNOLOGIE/Desktop/Input_Proteinsplitter/"
################################################################################
###                             Load libraries                               ###
################################################################################
## Uncomment this when the library is not installed at this point
# BiocManager::install("readxl")
library(readxl)
## Get the full path of the filenames that have an excel extention
filenames <- list.files(folder, pattern="*.xlsx", full.names=TRUE)
## Exclude the files that have "_single_proteins" in the name
filenames <- filenames[!grepl("_single_proteins", filenames)]

## Loop through all of the filenames in the directory
for(filename in filenames){
  ## Return the file which is currently being processed
  print(filename)
  ## Stor the information in a data frame
  data <- as.data.frame(read_excel(path = paste0(filename), sheet = 1))
  ## Make sure that the multimappers are changed to a single protein ids
  extractedUniprot <- strsplit(data$`Protein Group Accessions`, ";|,")
  
  ## Create a new data frame with all of the information extracted for the single proteins
  result <- data.frame(Sample= rep(data$Sample, sapply(extractedUniprot, length)), 
                       Sequence = rep(data$Sequence, sapply(extractedUniprot, length)), 
                       Uniprot = unlist(extractedUniprot),
                       check.names = F)
  ## Change the name to Single Proteins
  colnames(result)[3] <- "Single Proteins"
  ## Store the information in an excel file so it can be used further
  xlsx.file <- openxlsx::createWorkbook()
  openxlsx::addWorksheet(xlsx.file, "Sheet 1")
  openxlsx::writeData(xlsx.file, sheet = "Sheet 1", x =  result)
  openxlsx::saveWorkbook(xlsx.file, file = gsub(".xlsx", "_single_proteins.xlsx", filename), overwrite = T)
}
## "Done" is printed when all of the files in the directory have been processed
print("Done")

