#Created on 30Jan18
#Purpose: Create readable, uniques plots using the iMapInvasives data
#Authors:Lisa Chemplayil, Nicolina Sciaretti, Nick Huron
#This code requires the installation of the R package "Tidyverse"
#-----------------------------------------------------------------------------------------------
library(tidyverse)
#Loads packages needed
#----------------------------------------------------------------------------------------------
#Sort data

#Top 50 invasives

#Read in data
Data1 <- read.csv(file = "file:///C:/Users/Nicolina/Desktop/Invasive_SpeciesCSV.csv", header = TRUE, sep = ",")

#This is so the code works on Lisa's computer
Data1<-read.csv("C:/Users/lchem/OneDrive/Documents/all_obs_imap_18Dec17_v2_0.csv", header=TRUE, sep= ",")

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

#-------------------------------------------------------------------------------------------
