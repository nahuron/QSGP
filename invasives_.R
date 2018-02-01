#file header
#date
#title
#purpose
#authors
#assignment for class

#required packages
library(tidyverse)

#set directory
setwd("/Users/nicholashuron/Google Drive/")

#read in pa invasives data
invasives <- read_csv("./QuantSci_GP/data/PA_Invasive_Species/all_obs_imap_18Dec17_v2_0.csv")

dim(invasives)

####################################################################################################
##Make a barchart of the proportional number of records for each species name. 
#Make this figure neat, clean and titled. Use aesthetics that are unique. 
#Note, I do not require you to plot all the species if you cannot get a good figure with so many species. 
#Hint: Use your title to explain what you are plotting.
####################################################################################################

#check colnames to figure out where species names are found
colnames(invasives)
#state_scientific_name is a reliable name convention

#find the number of unique species names in this column and order them for easy dups check by sight
sort(unique(invasives$state_scientific_name))

#subset to only aquatic species
aqua.invasives <- filter(invasives, invasives$natlhabitat=="Aquatic")

#find the 25 aquatic species with the most observations
aqua <- aqua.invasives %>% count(state_scientific_name, sort = T) %>% .[1:25,]
#store in a new object
aqua.invasives.top <- aqua.invasives %>% filter(state_scientific_name %in% aqua$state_scientific_name)

#reorder the summary object aqua for plotting
aqua$state_scientific_name <- factor(aqua$state_scientific_name, levels = aqua$state_scientific_name[order(-aqua$n)])

#plot relative proportional number of records for the top 25 species (version with counts)
ggplot(data = aqua.invasives.top) +
  geom_bar(mapping = aes(x = reorder(x = state_scientific_name,X = -table(state_scientific_name)[state_scientific_name]), group=factor(0), y = ..prop.., fill = factor(..x..)), show.legend=FALSE) +
  coord_flip() +
  labs(y = "Proportion of Observations", x = "Invasive Species", title = "Proportional Prevalance Among the Top Twenty-Five \nMost Sighted Invasive Aquatic Species in PA")

#version with summary table instead (minus sign is missing in reorder to do descending order)
ggplot(data = aqua) +
  geom_bar(mapping = aes(x = reorder(state_scientific_name, n), y = (n/sum(n)), fill = factor(..x..)), stat = "identity", show.legend=FALSE) +
  coord_flip() +
  labs(y = "Proportion of Observations", x = "Invasive Species", title = "Proportional Prevalance Among the Top Twenty-Five \nMost Sighted Invasive Aquatic Species in PA")

####################################################################################################
##In a single plot (facets are encouraged), summarize the relationship between two or more variables of your choosing. 
#Use color, shape changes or other techniques you learned in Chapter 3. 
#Make your figures unique as it is unlikely that two people would code the exact same thing...
####################################################################################################

invasives.co <- invasives %>% count(County, sort=T)
invasives.sc <- invasives %>% count(state_scientific_name, sort = T)
invasives.na <- invasives %>% count(natlhabitat, sort=T)

invasives$County <- factor(invasives$County, levels = unique(invasives$County[order(invasives$County, decreasing = T)]))

ggplot(data = invasives) +
  geom_bar(mapping = aes(x = reorder(County, table(County)[County]), group = factor(0), fill= factor(..x..)), show.legend = FALSE) +
  coord_flip() +
  facet_wrap(~natlhabitat) +
  labs(y = "Invasive Species Observations", x = "County (Pennsylvania)", title ="Aquatic and Terrestrial Invasive Species Sightings by County")

ggplot(data = invasives) +
  geom_bar(mapping = aes(x = County, group = factor(0), fill= factor(..x..)), show.legend = FALSE) +
  coord_flip() +
  facet_wrap(~natlhabitat) +
  labs(y = "Invasive Species Observations", x = "County (Pennsylvania)", title ="Aquatic and Terrestrial Invasive Species Sightings by County")