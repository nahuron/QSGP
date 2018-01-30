#Created on 30Jan18
#Purpose: Create readable, uniques plots using the iMapInvasives data
#Authors:Lisa Chemplayil, Nicolina Sciaretti, Nick Huron
#This code requires the installation of the R package "Tidyverse"
#----------------------------------------------------------------------------------------------
library(tidyverse)
#Loads packages needed
#----------------------------------------------------------------------------------------------
#Part 1
####################################################################################################
##Make a barchart of the proportional number of records for each species name. 
#Make this figure neat, clean and titled. Use aesthetics that are unique. 
#Note, I do not require you to plot all the species if you cannot get a good figure with so many species. 
#Hint: Use your title to explain what you are plotting.
####################################################################################################

#Sort data

#Top 50 invasives

#Read in data
Data1 <- read.csv(file = "file:///C:/Users/Nicolina/Desktop/Invasive_SpeciesCSV.csv", header = TRUE, sep = ",")

#This is so the code works on Lisa's computer
Data1<-read.csv("C:/Users/lchem/OneDrive/Documents/all_obs_imap_18Dec17_v2_0.csv", header=TRUE, sep= ",")

#Nick's version 
Data1 <- read_csv("/Users/nicholashuron/Google Drive/QuantSci_GP/data/PA_Invasive_Species/all_obs_imap_18Dec17_v2_0.csv")

#Subset data to top 50 most observed species and create a summary table
invasives50 <- Data1 %>% count(state_scientific_name, sort = T) %>% .[1:50,]
#----------------------------------------------------------------------------------------------
#Plot the top 50 species by their proportional prevalence

ggplot(data = invasives50) +
  #bar plot that uses the summary table that is invasives50
  geom_bar(mapping = aes(x = reorder(state_scientific_name, n), y = (n/sum(n)), fill = factor(..x..)), stat = "identity", show.legend=FALSE) +
  coord_flip() +
  labs(y = "Proportion of Observations", x = "Invasive Species", title = "Proportional Prevalance Among the Top Fifty \nMost Observed Invasive Species in PA") +
  theme(axis.text.y = element_text(size = 10, face = "italic"))
#----------------------------------------------------------------------------------------------
#Part 2
####################################################################################################
##In a single plot (facets are encouraged), summarize the relationship between two or more variables of your choosing. 
#Use color, shape changes or other techniques you learned in Chapter 3. 
#Make your figures unique as it is unlikely that two people would code the exact same thing...
####################################################################################################

#We decided to subset by one of the most invasive species to see more about confirmed observations by county

#create summary table for H. verticillata
h_vert <- Data1 %>%
  filter(state_scientific_name == "Hydrilla verticillata") %>%
  group_by(`data status name`, County) %>%
  summarise(observations =n()) %>%
  arrange(desc(observations))
#----------------------------------------------------------------------------------------------
#plot the data as a faceted figure by data status name with bar charts of counts per county