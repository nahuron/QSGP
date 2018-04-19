#write a function for the data dryad dataset
library(fulltext)
library(reshape2)
library(devtools)
library(suppdata)
source('/Volumes/GoogleDrive/My Drive/RfDS/natdb/R/utility.R')

.kamath.2017d <- function(...){
  #download target dataset
  dl_data <- read.csv(
    suppdata(
      x = "10.5061/dryad.9vk07/4",
      si = "KamathLososEvol_AnolissagreiPerchDistAvailable.csv"),
    as.is = TRUE
  )
  
  #portion out metadata
  my_metadata <- as.data.frame(dl_data[,1])
  colnames(my_metadata) <- "ID"
  
  #portion out the focal data
  my_data <- dl_data[, -1]
  colnames(my_data) <- c("n_perches_0_1_cm_dia", 
                         "n_perches_1_5_cm_dia", 
                         "n_perches_5_10_cm_dia", 
                         "n_perches_10_20_cm_dia", 
                         "n_perches_20+_cm_dia"
                         )
  #add in species
  my_data$species <- "anolis_sagrei"
  
  #create units object
  my_units <- rep(NA, times = ncol(dl_data))
  
  #summary dataframe
  return_data <- .df.melt(
    x = my_data,
    spp = "species",
    units = my_units,
    metadata = my_metadata
  )
  
return(return_data)
}

.kamath.2017d()