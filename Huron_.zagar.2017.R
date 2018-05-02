#write a function for the Zagar paper
library(fulltext)
library(reshape2)
library(devtools)
library(suppdata)
source('/Volumes/GoogleDrive/My Drive/RfDS/natdb/R/utility.R')


.zagar.2017 <- function(...){
  
  #fetch original dataset
  data <- read.csv(suppdata(x = "10.5061/dryad.jn14f", si = "data.csv"), as.is = TRUE)
  
  #change the species labels to natdb format
  data$SP <- gsub(pattern = "IHOR", replacement = "iberolacerta_horvathi", x = data$SP)
  data$SP <- gsub(pattern = "PMUR", replacement = "podarcis_muralis", x = data$SP)
  
  #rename species col
  colnames(data)[colnames(data) %in% "SP"] <- "species"
  
  #separate out metadata
  #metadata <- as.data.frame(data[,3:5])
  #There are no metadata!
  
  #separate out focal data
  #it is everything!
  colnames(data) <- c("species", "sex", "max_bite_force", "max_run_speed", "max_climb_speed", "snout_vent_length", "trunk_length", "head_length", "pileus_length", "head_width", "head_height", "mouth_opening", "fore_limb_length", "hind_limb_length")
    
  #create units object
  myunits <- c(NA, "N", rep("cm/s", times = 2), rep("mm", times = 9))
  
  #summary dataframe
  data <- .df.melt(x = data, spp = "species", units = myunits)  
    
  return(data)
}

.zagar.2017()
