#Created on 30Jan18
#Purpose: Create readable, uniques plots using the iMapInvasives data
#Authors:Lisa Chemplayil, Nicolina Sciaretti, Nick Huron
#This code requires the installation of the R package "Tidyverse"
#----------------------------------------------------------------------------------------------
library(tidyverse)
#Loads packages needed
#----------------------------------------------------------------------------------------------
##Assignment 2B Part 1
####################################################################################################
##Make a barchart of the proportional number of records for each species name. 
#Make this figure neat, clean and titled. Use aesthetics that are unique. 
#Note, I do not require you to plot all the species if you cannot get a good figure with so many species. 
#Hint: Use your title to explain what you are plotting.
####################################################################################################
#Read in data (3 versions, one for each person)
#Lisa
Data1<-read.csv("C:/Users/lchem/OneDrive/Documents/all_obs_imap_18Dec17_v2_0.csv", header=TRUE, sep= ",")
#Nicolina
Data1 <- read.csv(file = "file:///C:/Users/Nicolina/Desktop/Invasive_SpeciesCSV.csv", header = TRUE, sep = ",")
#Nick 
Data1 <- read_csv("/Users/nicholashuron/Google Drive/QuantSci_GP/data/PA_Invasive_Species/all_obs_imap_18Dec17_v2_0.csv")
#----------------------------------------------------------------------------------------------
#Sort data

###Top 50 invasives (Lisa)
#Subset data to top 50 most observed species and create a summary table
invasives50 <- Data1 %>% count(state_scientific_name, sort = T) %>% .[1:50,]

###invasives of Chester Co. (Nicolina)
#Filtering by Chester County
Chester_Invasives <- filter(Data1, obscountyname == "Chester")

###Top 25 aquatic invasives (Nick)
#find the number of unique species names in this column and order them for easy dups check by sight
sort(unique(Data1$state_scientific_name))

#subset to only aquatic species
aqua.invasives <- filter(Data1, Data1$natlhabitat=="Aquatic")
#find the 25 aquatic species with the most observations
aqua <- aqua.invasives %>% count(state_scientific_name, sort = T) %>% .[1:25,]
#store in a new object
aqua.invasives.top <- aqua.invasives %>% filter(state_scientific_name %in% aqua$state_scientific_name)
#reorder the summary object aqua for plotting
aqua$state_scientific_name <- factor(aqua$state_scientific_name, levels = aqua$state_scientific_name[order(-aqua$n)])
#----------------------------------------------------------------------------------------------
#Plot the data

###Top 50 invasives (Lisa)
ggplot(data = invasives50) +
  #bar plot that uses the summary table that is invasives50
  geom_bar(mapping = aes(x = reorder(state_scientific_name, n), y = (n/sum(n)), fill = factor(..x..)), stat = "identity", show.legend=FALSE) +
  coord_flip() +
  labs(y = "Proportion of Observations", x = "Invasive Species", title = "Proportional Prevalance Among the Top Fifty \nMost Observed Invasive Species in PA") +
  theme(axis.text.y = element_text(size = 10, face = "italic"))

###invasives of Chester Co. (Nicolina)
#Title Barchat code for Chester County
ggplot(data = Chester_Invasives) +
  geom_bar(mapping = aes(x = stateCommonName, group=factor(0), y = ..prop.., fill = factor(..x..)), show.legend = FALSE) +
  coord_flip() +
  labs(title = "Proportions of Invasive Species in Chester County by State Common Name", y = "Proportions of Invasives", x = "State Common Name")

###Top 25 aquatic invasives (Nick)
#plot relative proportional number of records for the top 25 species (version with counts)
ggplot(data = aqua.invasives.top) +
  geom_bar(mapping = aes(x = reorder(x = state_scientific_name,X = -table(state_scientific_name)[state_scientific_name]), group=factor(0), y = ..prop.., fill = factor(..x..)), show.legend=FALSE) +
  coord_flip() +
  labs(y = "Proportion of Observations", x = "Invasive Species", title = "Proportional Prevalance Among the Top Twenty-Five \nMost Sighted Invasive Aquatic Species in PA")

#version with summary table instead (minus sign is missing in reorder to do descending order)
ggplot(data = aqua) +
  geom_bar(mapping = aes(x = reorder(state_scientific_name, n), y = (n/sum(n)), fill = factor(..x..)), stat = "identity", show.legend=FALSE) +
  coord_flip() +
  labs(y = "Proportion of Observations Among Top 25 Aquatic", x = "Invasive Species", title = "Proportional Prevalance Among the Top Twenty-Five Observed Invasive Aquatic Species in PA") +
  theme(axis.text.y = element_text(face = "italic"))

#----------------------------------------------------------------------------------------------
#Assignment 2B Part 2
####################################################################################################
##In a single plot (facets are encouraged), summarize the relationship between two or more variables of your choosing. 
#Use color, shape changes or other techniques you learned in Chapter 3. 
#Make your figures unique as it is unlikely that two people would code the exact same thing...
####################################################################################################
#----------------------------------------------------------------------------------------------
#subset the data

#subset by one of the most invasive species to see more about confirmed observations by county (Lisa)
#create summary table for H. verticillata, remove NA values in county
h_vert <- Data1 %>%
  filter(state_scientific_name == "Hydrilla verticillata" & !is.na(County)) %>%
  group_by(`data status name`, County) %>%
  summarise(observations =n()) %>%
  arrange(desc(observations))
#change the name of the first column to not include spaces
colnames(h_vert)[1] <- "data.status.name"

#view the data by county and facet by species ID method (Nicolina)
#need to remove NA values for ID method
methods <- Data1 %>% filter(!is.na(obsspeciesidmethod))
#and for county too
county_methods <- methods %>% filter(!is.na(obscountyname))

#another plot will look at county and aquatic vs terrestrial species (Nick)
#no subset is required other than to remove NA data for counties
invasives <- Data1 %>% filter(!is.na(County))
#make County a factor to make ordering the counties easier in the plot, we do reverse order to get the alpha order to play nice with coord_flip later
invasives$County <- factor(invasives$County, levels = unique(invasives$County[order(invasives$County, decreasing = T)]))


#----------------------------------------------------------------------------------------------
#plot the data as a faceted figure with bar charts

#H. verticillata plot by county and data status of observations (Lisa)
facetplot1<-ggplot(data = h_vert) +
  geom_col(mapping = aes(x= County, y=observations, fill = factor(..x..)), show.legend=FALSE) +
  facet_wrap(~data.status.name, nrow = 2)+
  ggtitle("Prevalence of Hydrilla Verticillata by County and by Data Status of the Observations")+
  labs(x="County Name", y="Number of Observations")
#rotate to make reading counties easier
facetplot1+coord_flip()

#county and facet by ID method (Nicolina)
ggplot(data = county_methods) +
  geom_bar(mapping = aes(x = County, group = factor(0), fill= factor(..x..)), show.legend = FALSE) +
  coord_flip() +
  facet_wrap(~obsspeciesidmethod, nrow = 1) +
  labs(y = "Invasive Species Observation Methods", x = "Counties in Pennsylvania", title ="Methods of Observations in Pennsylvania Counties")

#county and aquatic vs terrestrial plot (Nick)
ggplot(data = invasives) +
  #unlike the other plot, this one is more informative if ordered by county alphabetically
  geom_bar(mapping = aes(x = County, group = factor(0), fill= factor(..x..)), show.legend = FALSE) +
  coord_flip() +
  #group by natural habitat
  facet_wrap(~natlhabitat) +
  #now make sure labels are added
  labs(y = "Invasive Species Observations", x = "County (Pennsylvania)", title ="Aquatic and Terrestrial Invasive Species Observations by County")