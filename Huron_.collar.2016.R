#write a function for the Zagar paper
library(fulltext)
library(reshape2)
library(devtools)
library(suppdata)
source('/Volumes/GoogleDrive/My Drive/RfDS/natdb/R/utility.R')
##Authors:T. Thomson, N. Huron------------------------------------------------------------------------------------------------------

.collar.2016 <- function(...){
  #read in data
  data <- read.csv(suppdata(x="10.5061/dryad.2d7km",si="labyrinth_data.csv"), as.is = TRUE)
  data <- data[,c(-18)]
  data <- transform(data, species = paste(tolower(data$Genus), data$Species, sep = "_"))
  #drop old "Species" col
  data <- data[,!colnames(data) %in% "Species"]
  ###Create meta data object
  metadata <- data[, c(1, 2)] 
  ### Create focal data object
  data <- data[,c(17, 4:16)] 
  ### Rename columns
  colnames(data) <- c("species", "body_height","body_width","head_length","head_height","head_width","n_precaudal_vertebrae","precaudal_vertebrae_length","precaudal_vertebrae_height","precaudal_vertebrae_width","n_caudal_vertebrae","caudal_vertebrae_length","caudal_vertebrae_height","caudal_vertebrae_width")
  ### Add units column
  my_units <-c(rep("mm", 5), NA, rep("mm", 3), NA, rep("mm", 3))
  ### Add df.melt function
  to_return_data <-.df.melt(x=data,spp="species", units=my_units, metadata=metadata)
  #output
  return(to_return_data)
}


.collar.2016()
### Citations to the original source packages  ------------------------------------------------------------------------------------------------------
####Publication:"Collar DC, Quintero M, Buttler B, Ward AB, Mehta RS (2016) Body shape transformation along a shared axis of anatomical evolution in labyrinth fishes (Anabantoidei). Evolution 70(3): 555–567. https://doi.org/10.1111/evo.12887"
#### Dryad Package Cited: "Collar DC, Quintero M, Buttler B, Ward AB, Mehta RS (2016) Data from: Body shape transformation along a shared axis of anatomical evolution in labyrinth fishes (Anabantoidei). Dryad Digital Repository. https://doi.org/10.5061/dryad.2d7km"