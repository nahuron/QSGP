#write a function for the Goncalves paper
#Authors: N. Sciarretta, N. Huron
library(fulltext)
library(reshape2)
library(devtools)
library(suppdata)
source('/Volumes/GoogleDrive/My Drive/RfDS/natdb/R/utility.R')

#------------------Read in Data---------------------------
.goncalves.2018 <- function(...){
  temp <- tempfile()
  download.file("https://esajournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1002%2Fecy.2106&attachmentId=2172118256", temp)
  data <- read.csv(unzip(temp, "ATLANTIC_TR_all_data.csv"), as.is = TRUE)
  #rename binomial column to "species"
  colnames(data)[colnames(data) %in% 'binomial'] <- 'species'
  #change upper case letters to lower case letters
  data$species <- tolower(data$species)
  #use gsub to add _ between genus and species
  data$species <- gsub(x = data$species, pattern = " ", replacement = "_")
  #create metadata
  metadata <- as.data.frame(data)[,c(1:6,15:19)]
  colnames(metadata) <- c("ID_register", "species_ID", "group", "order", "family", "genus", "status", "longitude", "latitude", "year", "collector")
  #create trait data
  data <- data[,c(7:14)]
  colnames(data) <- c("species", "body_mass", "body_length", "tail_length", "forearm_length", "age", "sex", "reproductive_stage")
  #the units
  my_units <- c("g", rep("mm", 3), NA, NA, NA)
  #put it all together 
  return_data <- .df.melt(x = data, spp = "species", units = my_units, metadata = metadata)
  return(return_data)
}

.goncalves.2018()